# Password Generation Strategy

## Overview

Consistent password generation for all Azure infrastructure credentials following best practices.

## Requirements

- **Azure SQL Server**: 8-128 characters, 3 of 4 categories (uppercase, lowercase, numbers, special)
- **Azure VMs**: 12-123 characters, 3 of 4 categories (uppercase, lowercase, numbers, special)
- **Best Practice**: 20+ characters for enhanced security

## Implementation

### Password Generator: `scripts/New-SecurePassword.ps1`

```powershell
New-SecurePassword -Length 20
```

**Characteristics:**

- Default length: 20 characters (exceeds all Azure requirements)
- Includes: uppercase (A-Z), lowercase (a-z), numbers (2-9), special (!@#$%^&\*)
- Excludes ambiguous: 0, O, I, l, 1 (prevents confusion)
- Guarantees at least one character from each category
- Random shuffling for enhanced security

### Credentials Stored in Key Vault

| Secret Name          | Username     | Password Format         |
| -------------------- | ------------ | ----------------------- |
| `sql-admin-username` | jobsiteadmin | (username)              |
| `sql-admin-password` | -            | 20-char secure password |
| `wfe-admin-username` | azureadmin   | (username)              |
| `wfe-admin-password` | -            | 20-char secure password |

## Deployment Scripts

### Core Infrastructure: `deploy-core.ps1`

- Generates both SQL and WFE passwords using `New-SecurePassword`
- Passes passwords as secure parameters to Bicep
- Bicep stores passwords in Key Vault as secrets

### IaaS Infrastructure: `deploy-iaas-clean.ps1`

- Retrieves passwords from Key Vault using Azure CLI
- Uses stored credentials for VM and SQL Server creation
- No password generation needed (uses core secrets)

## Security Best Practices

✅ **DO:**

- Use `New-SecurePassword` function for all new credentials
- Store passwords in Key Vault immediately
- Use RBAC (Key Vault Secrets Officer) for access control
- Pass passwords via secure parameters in Bicep/ARM
- Generate unique passwords for each service

❌ **DON'T:**

- Use default passwords like "Password123!"
- Store passwords in plain text files
- Use newGuid() (GUID format doesn't meet complexity)
- Reuse passwords across environments
- Commit passwords to source control

## Password Retrieval

### For Administrators (Key Vault Secrets Officer):

```powershell
# Get SQL password
az keyvault secret show --vault-name kv-dev-swc-ubzfsgu4p5 --name sql-admin-password --query value -o tsv

# Get WFE password
az keyvault secret show --vault-name kv-dev-swc-ubzfsgu4p5 --name wfe-admin-password --query value -o tsv
```

### For Applications (Managed Identity):

- VMs use managed identity to retrieve secrets
- No password needed in code or config files

## Rotation Strategy

1. Generate new password: `New-SecurePassword -Length 20`
2. Update Key Vault secret
3. Update service credential (SQL login, VM password)
4. Test access
5. Document rotation in changelog

## Example: Deploy with Consistent Passwords

```powershell
# Generate passwords
. .\scripts\New-SecurePassword.ps1
$sqlPassword = New-SecurePassword -Length 20
$wfePassword = New-SecurePassword -Length 20

# Deploy core (stores in Key Vault)
az deployment sub create `
    --template-file ./bicep/core/main.bicep `
    --parameters sqlAdminPassword="$sqlPassword" wfeAdminPassword="$wfePassword"

# IaaS retrieves from Key Vault automatically
az deployment group create `
    --template-file ./bicep/iaas/main.bicep
```

## Compliance

- NIST SP 800-63B: Length > 8, complexity requirements met
- Azure Security Baseline: Secrets stored in Key Vault, not code
- CIS Azure Foundations: Strong passwords, secure storage
