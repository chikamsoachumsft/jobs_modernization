# JobSite Infrastructure - Constitution

Project principles and quality standards for Azure infrastructure specifications and implementation.

## Core Principles

### 1. Production Readiness

- All designs must follow Azure Well-Architected Framework recommendations
- Subnet sizing must accommodate maximum expected scale + 20% buffer
- No hardcoded credentials or security vulnerabilities
- Comprehensive logging, monitoring, and diagnostics enabled
- Changes driven through IaC only (no manual portal moves)

### 2. Scalability by Default

- VNet must provide 40%+ unallocated address space for growth
- Each subnet sized for 3-5x current resource count
- Architecture supports both vertical (instance size) and horizontal (replica count) scaling
- Network performance not constrained by IP allocation

### 3. Best Practices Adherence

- Application Gateway v2: Minimum /24 subnet (supports up to 125 instances)
- AKS: Minimum /23 with Azure CNI Overlay (supports 250+ nodes)
- Container Apps: /27 minimum for workload profiles
- All resources use Managed Identities, not connection strings or keys in code
- Follow Azure Naming Conventions (kebab-case, resource type prefix, environment suffix)

### 4. Cost Optimization

- Resource selection based on regional availability (Sweden Central: D-series v6 preferred)
- Network resources sized appropriately - oversizing adds no Azure cost
- Consolidate features into existing services (e.g., Container App Environment reuse)
- Cost tracking by RG layer for chargeback and budgeting

### 5. Security by Design

- Zero hardcoded credentials in templates or scripts
- All passwords/certificates managed via Azure Key Vault or parameters
- Private endpoints for sensitive resources (SQL, Key Vault, Storage)
- Network isolation with dedicated subnets per workload tier
- RBAC with principle of least privilege
- Microsoft Defender for Cloud enabled on all VMs

### 6. Operational Excellence

- Infrastructure as Code with Bicep (version-controlled, reviewable)
- Comprehensive documentation of design decisions and rationale
- Modular architecture allowing independent layer deployment
- Clear separation of concerns (Core → IaaS + PaaS → Agents)
- Automated deployment scripts with validation

## Quality Standards

### Documentation Quality

- [ ] Design rationale documented for each major decision
- [ ] References to Microsoft documentation for sizing recommendations
- [ ] Architecture diagrams showing resource relationships
- [ ] Cost analysis and budget impact statements
- [ ] Acceptance criteria clear and testable

### Code Quality

- [ ] No hardcoded values - all parameters configurable
- [ ] Consistent naming conventions applied
- [ ] Comments explaining non-obvious configuration choices
- [ ] DRY principle - no duplicate resource definitions
- [ ] Modular structure - easy to understand and maintain
- [ ] All Bicep files pass linting

### Testing & Validation

- [ ] All templates pass Bicep linting
- [ ] Dry-run deployments validate template syntax
- [ ] Subnet IP calculations verified against Azure requirements
- [ ] Network connectivity tested between tiers
- [ ] Cost estimates provided before deployment
- [ ] Monitoring/diagnostics verified working

### Security Standards

- [ ] No credentials in git history or logs
- [ ] All secrets stored in Key Vault
- [ ] Network security groups configured per tier
- [ ] Private endpoints for data access
- [ ] Managed identities for service-to-service auth
- [ ] RBAC audit clean (no overly permissive roles)

## Definition of Done

A specification feature is complete when:

1. ✅ Spec artifact describes the "what" clearly
2. ✅ Plan artifact describes the "how" with tech stack choices
3. ✅ All quality standards above are met
4. ✅ Implementation passes all validation tests
5. ✅ Documentation is complete and up-to-date
6. ✅ Team knowledge transfer completed
7. ✅ Deployment verified in target environment
8. ✅ Monitoring and diagnostics operational

## Tools & Standards

- **IaC Language**: Bicep (Azure ARM templates)
- **Linting**: Bicep linter with strict mode
- **Documentation**: Markdown with mermaid diagrams
- **Version Control**: Git with atomic commits per logical change
- **Deployment**: Azure CLI with PowerShell automation
- **Monitoring**: Azure Monitor + Log Analytics Workspace
- **Secrets Management**: Azure Key Vault
- **Compliance**: Azure Policy for standards enforcement
- **Security**: Microsoft Defender for Cloud + RBAC

## Resource Group Model

**4-Layer Architecture**:

- **Core (jobsite-core-dev-rg)**: Shared networking & services
- **IaaS (jobsite-iaas-dev-rg)**: Long-lived application VMs + Web Front End
- **PaaS (jobsite-paas-dev-rg)**: Managed services (auto-scaling)
- **Agents (jobsite-agents-dev-rg)**: Ephemeral build infrastructure

**Ownership**: Each layer has clear team responsibility and budget tracking

## Deployment Standards

- Deployments must be idempotent (safe to run multiple times)
- All parameters supplied via files or CLI (no hardcoding)
- Bicep outputs exported for downstream layers
- Validation procedures run after each phase
- Rollback procedures documented for each layer
- Blue-green deployments for production changes
