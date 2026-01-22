# JobSite Infrastructure - Plan

**Tech Stack**: Bicep, Azure CLI, PowerShell  
**Region**: Sweden Central  
**Approach**: Fresh deployment to correct RGs with comprehensive validation

---

## Architecture Overview

### 4-Layer Resource Group Model

```
┌─────────────────────────────────────────────────────┐
│ CORE (jobsite-core-dev-rg)                         │
│ ┌──────────────────────────────────────────────┐   │
│ │ VNet 10.50.0.0/21 + 7 Subnets               │   │
│ │ Key Vault, Log Analytics, Container Registry │   │
│ │ NAT Gateway, Private DNS Zones               │   │
│ └──────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────┘
           ↓ (consumed by all layers)
  ┌────────┴────────────────┬─────────────────┐
  ↓                         ↓                  ↓
IAAS                      PAAS             AGENTS
jobsite-iaas-dev-rg       jobsite-paas-    jobsite-agents-
                          dev-rg           dev-rg

┌──────────────────┐  ┌─────────────────┐  ┌──────────────┐
│ App Gateway v2   │  │ CAE + Apps      │  │ Build VMSS   │
│ Web VMSS         │  │ App Service     │  │              │
│ SQL VM           │  │ SQL Database    │  │ snet-gh-     │
│                  │  │ App Insights    │  │ runners      │
│ snet-fe, snet-   │  │ Private EPs     │  │              │
│ data             │  │                 │  │              │
└──────────────────┘  └─────────────────┘  └──────────────┘
```

### Network Architecture

**VNet**: 10.50.0.0/21 (2,048 IPs)

| Subnet          | CIDR                    | Usable IPs | Purpose                   | Max Scale      |
| --------------- | ----------------------- | ---------- | ------------------------- | -------------- |
| snet-fe         | 10.50.0.0/24            | 251        | App Gateway v2 (WFE)      | 125 instances  |
| snet-data       | 10.50.1.0/26            | 59         | SQL VMs                   | 10 VMs         |
| snet-gh-runners | 10.50.1.64/26           | 59         | Build agents VMSS         | 50 instances   |
| snet-pe         | 10.50.1.128/27          | 27         | Private endpoints         | 27 endpoints   |
| GatewaySubnet   | 10.50.1.160/27          | 27         | VPN Gateway               | 1 gateway      |
| snet-aks        | 10.50.2.0/23            | 507        | AKS cluster nodes         | 250+ nodes     |
| snet-ca         | 10.50.4.0/26            | 59         | Container Apps            | 50+ replicas   |
| **RESERVED**    | 10.50.4.64 - 10.50.7.255| 896        | Future growth             | —              |

---

## Architecture Decisions

### Decision 1: VNet Expansion (/24 → /21)

**Decision**: Use 10.50.0.0/21 (2,048 IPs)

**Rationale**:
- Current /24 has zero growth capacity (100% utilized)
- /21 provides 8x capacity with 44% reserved for growth
- No additional Azure cost for larger IP space
- Meets Microsoft's scalability recommendations

**Alternatives Considered**:
- /22 (1,024 IPs): Too tight for 3-5 year growth window
- /20 (4,096 IPs): Over-provisioning for dev environment
- Stay with /24: Confirmed blocker - prevents scaling

**Outcome**: Proceed with /21 (10.50.0.0/21)

---

### Decision 2: 4-Layer RG Organization

**Decision**: Separate resource groups by lifecycle and ownership

**Rationale**:
- **Core**: Rarely changes (quarterly or less), shared by all layers
- **IaaS**: Medium change rate, manual scaling, long-lived resources
- **PaaS**: Frequent changes (weekly), auto-scaling, managed services
- **Agents**: High change rate (hourly), ephemeral, queue-based scaling

**Benefits**:
- Clear ownership boundaries
- Independent cost tracking per layer
- Different security/compliance posture per layer
- Easier to update agent images without touching production
- Can be managed by different teams

**Outcome**: 4-layer model with dedicated RGs

---

### Decision 3: Web Front End (App Gateway v2)

**Decision**: Deploy Application Gateway v2 (WAF_v2) in IaaS RG

**Rationale**:
- Current architecture lacks HTTP/HTTPS ingress
- App Gateway v2 provides:
  - Load balancing across VMSS
  - WAF protection (OWASP 3.1)
  - SSL/TLS termination
  - Path-based routing
  - Health probes

**Configuration**:
- SKU: WAF_v2
- Subnet: snet-fe (/24 for scaling to 125 instances)
- Backend: Web VMSS in snet-data
- Capacity: 2-10 (auto-scale)
- WAF Mode: Detection (dev), Prevention (prod)

**Outcome**: Deploy in IaaS RG with complete monitoring

---

### Decision 4: Build Agent Isolation

**Decision**: Dedicated RG (jobsite-agents-dev-rg) for GitHub Runners VMSS

**Rationale**:
- Build agents are ephemeral (created/destroyed frequently)
- Different lifecycle from long-lived app VMs
- Independent scaling policy (queue-based, not CPU-based)
- Separate cost tracking for CI/CD infrastructure
- Allows updating agent image without affecting production

**Configuration**:
- VMSS in agents RG using snet-gh-runners from Core VNet
- Auto-scale: 1-5 instances based on queue depth
- Outbound via NAT Gateway (in Core RG)
- Can reach all tiers via VNet peering

**Outcome**: New agents RG with proper isolation

---

### Decision 5: Deployment Strategy

**Decision**: Fresh deployment to correct RGs for dev; no manual portal moves

**Rationale**:
- Lower risk than moving live resources
- Consistent with IaC principles
- Easier to validate and test
- Can be repeated safely
- Dev environment - no customer impact

**Procedure**:
1. Deploy Core (validates subnet outputs)
2. Deploy IaaS (with App Gateway)
3. Deploy PaaS (with CAE)
4. Deploy Agents (with VMSS)
5. Validate all connectivity
6. Remove old misplaced resources

**Timeline**: 3-4 hours for complete deployment + validation

---

### Decision 6: Monitoring & Security

**Decision**: Log Analytics in Core, diagnostics on all layers

**Rationale**:
- Centralized observability
- Traces network patterns across all RGs
- Cost efficient (single LAW instance)
- Meets security/compliance requirements
- Microsoft Defender for Cloud on all VMs

**Configuration**:
- VNet diagnostics → LAW
- App Gateway logs → LAW
- VMSS guest diagnostics → LAW
- App Service diagnostics → App Insights + LAW
- Container Apps → LAW

**Outcome**: Full observability with security event tracking

---

## Implementation Timeline

### Phase 1: Preparation (1-2 hours)
- Validate Bicep templates
- Backup current configurations
- Plan migration approach
- Team alignment

### Phase 2: Deployment (3-4 hours)
- Deploy Core layer
- Deploy IaaS layer (with App Gateway)
- Deploy PaaS layer
- Deploy Agents layer
- Validate all deployments

### Phase 3: Validation (1-2 hours)
- Network connectivity tests
- IP allocation verification
- Diagnostics verification
- Application health checks

### Phase 4: Documentation (1 hour)
- Update architecture diagrams
- Create runbooks for common tasks
- Document lessons learned
- Team knowledge transfer

**Total Effort**: 8-12 hours (1-2 person team)

---

## Risk Assessment

| Risk                       | Likelihood | Impact | Mitigation                                  |
| -------------------------- | ---------- | ------ | ------------------------------------------- |
| VMSS network profile fails | Low        | High   | Validate networkApiVersion in Bicep         |
| IP conflict                | Low        | High   | Pre-validate all CIDR ranges                |
| NSG rules too restrictive  | Medium     | Medium | Test connectivity from each tier            |
| App Gateway backend fails  | Low        | High   | Verify backend pool + health probes         |
| Cost overruns              | Low        | Medium | Review pricing calculator for all services  |
| Long deployment time       | Low        | Medium | Deploy Core/IaaS/PaaS in parallel           |

**Fallback**: Keep old network as fallback if critical issues

---

## Cost Estimates

| Resource             | Type       | Qty | Price/Month | Total   |
| -------------------- | ---------- | --- | ----------- | ------- |
| VNet                 | Networking | 1   | $0          | $0      |
| NAT Gateway          | Egress     | 1   | ~$32        | $32     |
| Public IP - WFE      | IP Address | 1   | ~$3         | $3      |
| App Gateway v2 (2u)  | Gateway    | 1   | ~$27        | $27     |
| **Total Networking** | —          | —   | —           | **$62** |

_Note: Most significant costs from compute (VMSS, App Service, SQL), not networking._

---

## Success Criteria

✅ **Functional**:
- All subnets created with correct CIDRs
- App Gateway v2 operational with healthy backends
- Build agents running and reachable
- Container Apps in correct RG
- All services interconnected

✅ **Performance**:
- Core deployment < 10 minutes
- Full stack < 20 minutes
- No observable latency increase

✅ **Security**:
- No hardcoded credentials
- All secrets in Key Vault
- NSGs properly configured
- Audit logging enabled

✅ **Operations**:
- Monitoring/diagnostics operational
- Team trained on new design
- Documentation complete
- Runbooks created for common tasks
