# Tasks: JobSite Network & Infrastructure Redesign

**Input**: Design documents from `/specs/001-network-redesign/` and `002-infra-reorg/`  
**Features**: 001 Network Redesign, 002 Infrastructure Reorganization  
**Status**: Ready for implementation  
**Target**: Fresh deployment to correct resource groups with Bicep IaC

---

## Implementation Strategy

This is a **two-feature infrastructure project** with sequential dependencies:

1. **Feature 001 (Network Redesign)**: Must complete first - establishes VNet architecture
2. **Feature 002 (Infrastructure Reorganization)**: Depends on 001 - deploys layers into correct RGs

**MVP Scope**: Both features (complete fresh infrastructure deployment)  
**Timeline**: 8-12 hours (1-2 person team)  
**Deployment Order**: Core → IaaS (App Gateway) → PaaS → Agents → Validation

---

## Phase 1: Preparation & Validation

**Purpose**: Ensure all Bicep templates are ready and validated

- [ ] T001 Validate existing Bicep templates in iac/bicep/ for syntax errors
- [ ] T002 Review and document current network configuration (reference for migration)
- [ ] T003 Create backup plan and document rollback procedures in iac/DEPLOYMENT_STATUS.md
- [ ] T004 [P] Validate all CIDR ranges to prevent IP conflicts
- [ ] T005 [P] Verify Key Vault exists and contains all required secrets
- [ ] T006 [P] Confirm regional availability (Sweden Central) for all resource types

**Checkpoint**: All prerequisites validated, team aligned on deployment approach

---

## Phase 2: Foundational Infrastructure (Core Layer)

**Purpose**: Deploy shared networking and security infrastructure - BLOCKING for all other layers

**Story Goal**: Establish the network backbone (VNet, subnets, NSGs, Key Vault, monitoring)

**Independent Test**: Verify VNet exists with all 7 subnets, Log Analytics workspace operational, Key Vault accessible

### Implementation for Core Layer

- [ ] T007 [P] Create Core VNet (10.50.0.0/21) in jobsite-core-dev-rg via iac/bicep/core.bicep
- [ ] T008 [P] Create all 7 subnets in correct CIDR ranges:
  - snet-fe (10.50.0.0/24)
  - snet-data (10.50.1.0/26)
  - snet-gh-runners (10.50.1.64/26)
  - snet-pe (10.50.1.128/27)
  - GatewaySubnet (10.50.1.160/27)
  - snet-aks (10.50.2.0/23)
  - snet-ca (10.50.4.0/26)
- [ ] T009 [P] Configure Network Security Groups (NSGs) for each subnet with base rules
- [ ] T010 [P] Deploy NAT Gateway and Public IP for outbound connectivity
- [ ] T011 [P] Create Log Analytics Workspace for centralized monitoring
- [ ] T012 [P] Create Private DNS Zones for internal service discovery
- [ ] T013 Configure VNet diagnostics to flow to Log Analytics
- [ ] T014 Validate subnet outputs and document in iac/DEPLOYMENT_STATUS.md
- [ ] T015 Update iac/core.bicep outputs to include all subnet IDs and VNet details

**Checkpoint**: Core infrastructure deployed and validated - all layers can now proceed in parallel

---

## Phase 3: Infrastructure Reorganization - IaaS Layer (Story 002)

**Goal**: Deploy Application Gateway v2 (Web Front End) + Web/SQL VMs with correct sizing

**Independent Test**: App Gateway health probes show green, backend pool has healthy instances

### Implementation for IaaS Layer

- [ ] T016 [P] Deploy Application Gateway v2 (WAF_v2) in snet-fe via iac/bicep/iaas.bicep
  - Configure WAF rules (OWASP 3.1) in Detection mode
  - Setup backend pool for Web VMSS
  - Enable health probes (HTTP 200 on /health)
  - Public IP + DNS name
- [ ] T017 [P] Deploy Web VMSS (D2ds_v6, 2-5 instances) in snet-data
  - Configure auto-scale policy (CPU-based 30-70%)
  - Health probe integration
  - Custom script extension for application setup
- [ ] T018 [P] Deploy SQL Server VM (D4ds_v6) in snet-data
  - Attach data disks for database files
  - Configure SQL Server 2022 Enterprise
  - Setup backup policy
- [ ] T019 Configure NSG rules for IaaS layer (allow App Gateway → Web, Web → SQL)
- [ ] T020 [P] Assign Network Interfaces to correct subnets
- [ ] T021 Enable IaaS diagnostics to Log Analytics
- [ ] T022 Validate App Gateway backend health and document in iac/DEPLOYMENT_STATUS.md
- [ ] T023 Test connectivity from App Gateway to backend pool

**Checkpoint**: IaaS layer operational with App Gateway traffic flowing to healthy backends

---

## Phase 4: Infrastructure Reorganization - PaaS Layer (Story 002)

**Goal**: Move/redeploy Container Apps Environment to jobsite-paas-dev-rg, configure managed services

**Independent Test**: Container Apps Environment operational, App Service running, SQL Database connected

### Implementation for PaaS Layer

- [ ] T024 [P] Deploy Container Apps Environment in snet-ca via iac/bicep/paas.bicep
- [ ] T025 [P] Deploy Container App instances (web, api, worker roles) with proper image refs
- [ ] T026 [P] Deploy App Service Plan (Premium tier) in jobsite-paas-dev-rg
- [ ] T027 [P] Deploy App Service instance for legacy ASP.NET apps
- [ ] T028 [P] Deploy Azure SQL Database in jobsite-paas-dev-rg
  - Setup firewall rules to allow PaaS VNet access
  - Configure private endpoint in snet-pe
  - Enable diagnostics to Log Analytics
- [ ] T029 [P] Create Application Insights for monitoring PaaS tier
- [ ] T030 Create Private Endpoints for KV, SQL, ACR in snet-pe
- [ ] T031 Configure PaaS NSG rules (snet-ca → snet-pe, snet-ca → internet via NAT)
- [ ] T032 Configure App Service networking (VNet integration with snet-ca subnets)
- [ ] T033 [P] Setup connection strings in Key Vault (SQL, App Insights instrumentation keys)
- [ ] T034 Validate PaaS connectivity to database and dependencies
- [ ] T035 Enable PaaS diagnostics to Log Analytics

**Checkpoint**: PaaS layer operational with all managed services properly connected

---

## Phase 5: Infrastructure Reorganization - Agents Layer (Story 002)

**Goal**: Deploy Build Agent VMSS in jobsite-agents-dev-rg with queue-based auto-scaling

**Independent Test**: Agents VMSS deployed, can reach GitHub Actions, NAT Gateway working

### Implementation for Agents Layer

- [ ] T036 Deploy GitHub Runners VMSS in snet-gh-runners via iac/bicep/agents.bicep
  - Auto-scale policy: 1-5 instances based on queue depth
  - Custom image with GitHub Actions runner pre-installed
  - Managed identity for Azure container access
- [ ] T037 [P] Configure outbound NAT via NAT Gateway (in Core RG)
- [ ] T038 [P] Configure agents NSG rules (allow egress to GitHub, restricted ingress)
- [ ] T039 [P] Setup VMSS health probes and monitoring
- [ ] T040 Create system-assigned managed identity for agents VMSS
- [ ] T041 Assign RBAC roles for agents to access ACR and Key Vault
- [ ] T042 Configure Custom Script Extension to register agents with GitHub
- [ ] T043 Enable agents diagnostics to Log Analytics
- [ ] T044 Validate agents connectivity to GitHub and core services

**Checkpoint**: Agents layer operational with queue-based scaling and proper GitHub integration

---

## Phase 6: Comprehensive Validation & Testing

**Purpose**: Verify all 4 layers are deployed correctly and interconnected properly

### Connectivity & Architecture Tests

- [ ] T045 [P] Verify all 7 subnets exist with correct CIDR ranges
- [ ] T046 [P] Verify all 4 resource groups exist with correct names
- [ ] T047 [P] Verify VNet has correct routes to Azure services
- [ ] T048 [P] Test connectivity from each tier to all dependencies:
  - App Gateway → Web VMSS
  - Web VMSS → SQL VM
  - PaaS tier (App Service) → SQL Database
  - Agents → GitHub Actions
- [ ] T049 [P] Verify DNS resolution for private endpoints
- [ ] T050 [P] Test outbound internet connectivity via NAT Gateway

### Security & Monitoring Tests

- [ ] T051 [P] Verify all NSGs are properly configured (no overly permissive rules)
- [ ] T052 [P] Verify all secrets are in Key Vault (no hardcoded credentials)
- [ ] T053 [P] Confirm Log Analytics is receiving diagnostics from all layers
- [ ] T054 [P] Verify Application Insights is collecting PaaS metrics
- [ ] T055 [P] Test Key Vault access from all compute layers (RBAC + MSI)
- [ ] T056 [P] Verify Container Registry access from PaaS and Agents

### Performance & Cost Tests

- [ ] T057 Test auto-scaling behavior under load (manually or via load test)
- [ ] T058 [P] Verify no orphaned resources exist outside target RGs
- [ ] T059 [P] Review deployment costs vs. estimates from plan.md
- [ ] T060 Document any cost overruns or optimizations needed

**Checkpoint**: All layers validated and interconnected, ready for production access

---

## Phase 7: Documentation & Handoff

**Purpose**: Document the deployment and create operational runbooks

- [ ] T061 Update architecture diagrams in docs/reference/ with new network design
- [ ] T062 Create runbook for common operational tasks:
  - Scaling Web VMSS
  - Managing build agents
  - Database backups
  - Adding new subnets to reserved space
- [ ] T063 Document lessons learned and deployment decisions in iac/DEPLOYMENT_STATUS.md
- [ ] T064 Create troubleshooting guide for common network issues
- [ ] T065 Update README.md with new 4-layer architecture overview
- [ ] T066 Conduct team knowledge transfer session (document in wiki)

**Checkpoint**: Full documentation complete, team trained on new architecture

---

## Phase 8: Cleanup & Fallback (If Needed)

**Purpose**: Remove old misplaced resources and prepare for next deployment

- [ ] T067 Verify backup of old network configuration is accessible
- [ ] T068 List all resources currently in wrong RGs (e.g., Container Apps in core RG)
- [ ] T069 Remove old/misplaced Container Apps Environment from jobsite-core-dev-rg
- [ ] T070 [P] Remove old subnet configuration (only if new subnets confirmed working)
- [ ] T071 [P] Remove old NSG rules that are no longer needed
- [ ] T072 Verify no orphaned resources remain outside target RGs
- [ ] T073 Final cost review and resource cleanup

**Checkpoint**: Old resources cleaned up, new infrastructure ready for production traffic

---

## Dependency Graph

```
Phase 1: Preparation ✅
         ↓
Phase 2: Core Layer (Network) - BLOCKING for all others
         ↓
    ┌────┴─────┬──────────┐
    ↓          ↓          ↓
  IaaS      PaaS      Agents     (can run in parallel)
  Layer     Layer      Layer
    ↓          ↓          ↓
    └────┬─────┴──────────┘
         ↓
  Phase 6: Validation (all layers)
         ↓
  Phase 7: Documentation
         ↓
  Phase 8: Cleanup & Handoff
```

---

## Parallel Execution Examples

### Phase 2 (Core Layer)

- All T007-T012 can run in parallel (different subnets, independent resources)
- T013-T015 depend on completion of above

### Phases 3-5 (IaaS, PaaS, Agents)

- T016-T023 (IaaS) ✓ parallel
- T024-T035 (PaaS) ✓ parallel
- T036-T044 (Agents) ✓ parallel
- **All three phases run in parallel** after Phase 2 completes

### Phase 6 (Validation)

- All tests marked [P] can run in parallel
- Other tests should run sequentially to isolate issues

---

## Success Criteria

**Network Redesign (001)**:

- ✅ VNet expanded to /21 with 7 correctly-sized subnets
- ✅ 44% capacity reserved for growth
- ✅ All subnets follow Microsoft best practices
- ✅ NSGs configured per tier
- ✅ Deployment time < 15 minutes

**Infrastructure Reorganization (002)**:

- ✅ 4 resource groups properly organized (Core, IaaS, PaaS, Agents)
- ✅ App Gateway v2 operational with WAF and healthy backends
- ✅ Build agents deployed and reachable via NAT Gateway
- ✅ Container Apps in correct RG with proper networking
- ✅ All resources accessible and interconnected
- ✅ Full diagnostics flowing to Log Analytics
- ✅ Zero hardcoded credentials (all in Key Vault)

**Overall**:

- ✅ All Bicep templates validate without errors
- ✅ Deployment automated via IaC (no manual portal changes)
- ✅ Full audit logging enabled
- ✅ Team trained and documented
- ✅ Ready for production traffic cutover

---

## Task Count Summary

- **Total Tasks**: 73
- **Setup & Preparation**: 6 tasks
- **Core Layer (Foundational)**: 9 tasks
- **IaaS Layer (Story 002)**: 8 tasks
- **PaaS Layer (Story 002)**: 12 tasks
- **Agents Layer (Story 002)**: 9 tasks
- **Validation**: 16 tasks (14 parallelizable)
- **Documentation**: 6 tasks
- **Cleanup**: 7 tasks

**Parallelizable Tasks**: 44 (60% can run concurrently)  
**Estimated Execution Time**: 8-12 hours (1-2 person team)  
**Recommended MVP**: All phases (complete infrastructure)

---

## Notes

- **No Tests**: This is infrastructure deployment; validation is done via connectivity/health checks, not unit tests
- **IaC-First**: All changes must be driven via Bicep templates, no manual portal operations
- **Bicep Path**: All templates should be in `iac/bicep/` (core.bicep, iaas.bicep, paas.bicep, agents.bicep)
- **Scripts Path**: PowerShell deployment scripts in `iac/scripts/`
- **All paths** assume Windows PowerShell or Azure CLI environment per plan.md
