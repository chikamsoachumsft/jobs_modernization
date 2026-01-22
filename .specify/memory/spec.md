# JobSite Network & Infrastructure Redesign

**Features**:
- 001: Network Redesign (VNet /24 → /21, subnet sizing, production-ready architecture)
- 002: Infrastructure Reorganization (4-layer RG model, App Gateway WFE, build agent isolation)

**Status**: Specifications complete and ready for implementation

---

## 001: Network Redesign - Specification

**Feature**: Azure VNet redesign for production-ready infrastructure  
**Scope**: Networking layer (Core infrastructure)  
**Status**: Ready for Implementation  
**Last Updated**: 2026-01-21

### Overview

The current network architecture uses a /24 VNet split into seven /27 subnets, leaving no room for growth and violating Microsoft's recommended subnet sizes for Application Gateway v2 and AKS deployments. This specification outlines a redesigned network that:

- Expands VNet from /24 to /21 (8x more capacity)
- Rightsizes all subnets to follow Azure best practices
- Reserves 44% capacity for future growth
- Maintains cost efficiency (no additional Azure charges)
- Supports production-scale workloads

### Business Requirements

#### Growth & Scalability
- **BR-001**: Network must support 3-5x growth in resource count
- **BR-002**: Application Gateway must scale to 125 instances without IP exhaustion
- **BR-003**: AKS cluster must support 250+ nodes with standard workloads
- **BR-004**: Container Apps environment must support production-level replica scaling

#### Operational Requirements
- **OR-001**: All resources must follow Microsoft Well-Architected Framework recommendations
- **OR-002**: Implement monitoring and diagnostics for all networking resources
- **OR-003**: Support both dev and production deployments with same network design
- **OR-004**: Enable future addition of services (API Gateway, Load Balancer, etc.)

#### Security & Compliance
- **SR-001**: Separate subnets for different workload tiers (frontend, data, private endpoints)
- **SR-002**: Build agents must have isolated subnet (snet-gh-runners)
- **SR-003**: SQL workloads must have dedicated, protected subnet
- **SR-004**: Private endpoints for sensitive services must be available

#### Cost Requirements
- **CR-001**: No increase in Azure networking costs (VNet/subnet resizing free)
- **CR-002**: Resource sizing optimized for regional availability
- **CR-003**: Support cost-effective regional choices (e.g., D-series v6 in Sweden Central)

### Target Network Architecture

| Subnet          | Current        | Target                   | Usable IPs | Justification                                      |
| --------------- | -------------- | ------------------------ | ---------- | -------------------------------------------------- |
| snet-fe         | 10.50.0.0/27   | 10.50.0.0/24             | 251        | App Gateway v2 needs 251 IPs min for 125 instances |
| snet-data       | 10.50.0.32/27  | 10.50.1.0/26             | 59         | SQL VMs + future database servers                  |
| snet-gh-runners | 10.50.0.128/27 | 10.50.1.64/26            | 59         | VMSS build agents, supports 50+ instances          |
| snet-pe         | 10.50.0.96/27  | 10.50.1.128/27           | 27         | Private endpoints (27 IPs sufficient)              |
| GatewaySubnet   | 10.50.0.64/27  | 10.50.1.160/27           | 27         | VPN gateway (meets /27 recommendation)             |
| snet-aks        | 10.50.0.160/27 | 10.50.2.0/23             | 507        | Azure CNI Overlay: 507 IPs for 250+ nodes          |
| snet-ca         | 10.50.0.192/27 | 10.50.4.0/26             | 59         | Container Apps: 12 infra + 47 for scaling          |
| **Reserved**    | -              | 10.50.4.64 - 10.50.7.255 | 896        | ~896 IPs for future expansion                      |

**Total VNet**: 10.50.0.0/21 (2,048 IPs)  
**Allocated**: 1,152 IPs (56%)  
**Reserved**: 896 IPs (44%)

### Acceptance Criteria

- [ ] All 7 subnets created with correct CIDR ranges
- [ ] Application Gateway v2 (WFE) deployed in IaaS RG with public IP and WAF
- [ ] Build agents (VMSS) deployed in Agents RG using snet-gh-runners
- [ ] Container Apps Environment deployed in PaaS RG using snet-ca
- [ ] VNet routes to Azure services properly configured
- [ ] NAT Gateway applies to required subnets
- [ ] Private DNS zone created for internal service discovery
- [ ] All Bicep templates validate without errors
- [ ] Network diagnostics enabled and flowing to Log Analytics
- [ ] No hardcoded credentials in templates or scripts
- [ ] All subnets have Network Security Groups configured
- [ ] Private endpoints available for sensitive services (KV, SQL, ACR)

---

## 002: Infrastructure Reorganization - Specification

**Goal**: Correct resource placement, add missing Web Front End, and formalize the 4-layer RG model.  
**Status**: Ready for Implementation  
**Last Updated**: 2026-01-21

### Target State

#### Resource Group Organization

- **jobsite-core-dev-rg**: Shared networking infrastructure
  - VNet (10.50.0.0/21)
  - 7 Subnets
  - Key Vault
  - Log Analytics Workspace
  - Container Registry
  - NAT Gateway + Public IP
  - Private DNS Zones

- **jobsite-iaas-dev-rg**: Application tier VMs + Web Front End
  - Application Gateway v2 (WAF_v2) ← NEW
  - Public IP (App Gateway) ← NEW
  - Web VMSS (D2ds_v6)
  - SQL Server VM (D4ds_v6)
  - Network Interfaces & Disks

- **jobsite-paas-dev-rg**: Managed services
  - Container Apps Environment (moved from core)
  - Container Apps instances
  - App Service Plan
  - App Service
  - SQL Database
  - Application Insights
  - Private Endpoints

- **jobsite-agents-dev-rg**: Build infrastructure (NEW)
  - GitHub Runners VMSS
  - Network Interfaces
  - Disks

### Acceptance Criteria

- [ ] jobsite-paas-dev-rg contains Container Apps Environment
- [ ] jobsite-agents-dev-rg contains GitHub Runner VMSS in snet-gh-runners
- [ ] jobsite-iaas-dev-rg contains Application Gateway v2 with public IP
- [ ] Core RG unchanged except for output additions
- [ ] All Bicep deployments succeed
- [ ] App Gateway health probes green
- [ ] Build agents can reach web tier and internet
- [ ] Diagnostics flowing to Log Analytics
- [ ] No stray resources outside target RGs
- [ ] All changes driven via IaC (no portal moves)

---

## Success Criteria

**Network Redesign**:
- ✅ VNet properly sized with 44% growth buffer
- ✅ All subnets follow Microsoft best practices
- ✅ Deployment time < 15 minutes
- ✅ Zero security vulnerabilities
- ✅ Full audit logging enabled

**Infrastructure Reorganization**:
- ✅ 4-layer RG model properly implemented
- ✅ App Gateway WFE operational with WAF
- ✅ Build agents isolated and operational
- ✅ Container Apps in correct RG
- ✅ All resources accessible and healthy
