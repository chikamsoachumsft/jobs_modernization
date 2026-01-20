# ============================================================================
# Bicep Deployment Script for Legacy Job Site Application
# ============================================================================
# Usage: 
#   ./Deploy-Bicep.ps1 -Environment dev -ResourceGroupName jobsite-dev-rg
#   ./Deploy-Bicep.ps1 -Environment prod -ResourceGroupName jobsite-prod-rg
#
# Prerequisites:
#   - Azure CLI or Azure PowerShell installed
#   - Logged in to Azure (az login or Connect-AzAccount)
#   - Appropriate permissions in target subscription
# ============================================================================

param(
    [Parameter(Mandatory = $true)]
    [ValidateSet('dev', 'staging', 'prod')]
    [string]$Environment,

    [Parameter(Mandatory = $true)]
    [string]$ResourceGroupName,

    [string]$Location = 'eastus',

    [string]$SubscriptionId = $null,

    [switch]$WhatIf = $false
)

# ============================================================================
# Configuration
# ============================================================================

$ErrorActionPreference = 'Stop'
$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$bicepFile = Join-Path $scriptRoot 'main.bicep'
$paramFile = Join-Path $scriptRoot "main.$Environment.bicepparam"
$timestamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$deploymentName = "jobsite-deploy-$Environment-$timestamp"

Write-Host "═══════════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "Job Site Application - Bicep Deployment ($Environment)" -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""

# ============================================================================
# Validation
# ============================================================================

Write-Host "📋 Validating deployment prerequisites..." -ForegroundColor Yellow

if (-not (Test-Path $bicepFile)) {
    Write-Host "❌ Bicep file not found: $bicepFile" -ForegroundColor Red
    exit 1
}

if (-not (Test-Path $paramFile)) {
    Write-Host "❌ Parameter file not found: $paramFile" -ForegroundColor Red
    exit 1
}

# Check for Azure CLI or PowerShell
$hasAzCli = $null -ne (Get-Command az -ErrorAction SilentlyContinue)
$hasAzPs = $null -ne (Get-Command Get-AzContext -ErrorAction SilentlyContinue)

if (-not $hasAzCli -and -not $hasAzPs) {
    Write-Host "❌ Azure CLI or Azure PowerShell is required" -ForegroundColor Red
    exit 1
}

Write-Host "✅ Prerequisites validated" -ForegroundColor Green
Write-Host ""

# ============================================================================
# Azure Connection
# ============================================================================

Write-Host "🔐 Connecting to Azure..." -ForegroundColor Yellow

if ($hasAzPs) {
    $context = Get-AzContext
    if (-not $context) {
        Write-Host "Please login to Azure..."
        Connect-AzAccount
    }

    if ($SubscriptionId) {
        Set-AzContext -SubscriptionId $SubscriptionId | Out-Null
    }
}
else {
    $account = az account show 2>$null
    if (-not $account) {
        Write-Host "Please login to Azure..."
        az login
    }
}

Write-Host "✅ Connected to Azure" -ForegroundColor Green
Write-Host ""

# ============================================================================
# Resource Group
# ============================================================================

Write-Host "📦 Checking resource group: $ResourceGroupName" -ForegroundColor Yellow

if ($hasAzPs) {
    $rg = Get-AzResourceGroup -Name $ResourceGroupName -ErrorAction SilentlyContinue
    
    if (-not $rg) {
        Write-Host "Creating resource group: $ResourceGroupName in $Location"
        $rg = New-AzResourceGroup -Name $ResourceGroupName -Location $Location -Tags @{
            environment  = $Environment
            application  = 'jobsite'
            deployedDate = Get-Date -Format 'u'
        }
    }
}
else {
    $rg = az group show --name $ResourceGroupName 2>$null
    
    if (-not $rg) {
        Write-Host "Creating resource group: $ResourceGroupName in $Location"
        az group create --name $ResourceGroupName --location $Location --tags @{
            environment = $Environment
            application = 'jobsite'
        }
    }
}

Write-Host "✅ Resource group ready: $ResourceGroupName" -ForegroundColor Green
Write-Host ""

# ============================================================================
# Bicep Validation
# ============================================================================

Write-Host "🔍 Validating Bicep template..." -ForegroundColor Yellow

$validateCmd = @(
    'deployment', 'group', 'validate',
    '--resource-group', $ResourceGroupName,
    '--template-file', $bicepFile,
    '--parameters', $paramFile
)

$validateResult = az @validateCmd 2>&1

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Bicep validation failed:" -ForegroundColor Red
    Write-Host $validateResult
    exit 1
}

Write-Host "✅ Bicep template validated" -ForegroundColor Green
Write-Host ""

# ============================================================================
# Deployment
# ============================================================================

Write-Host "🚀 Starting deployment..." -ForegroundColor Yellow
Write-Host "Deployment Name: $deploymentName" -ForegroundColor Gray
Write-Host "Environment: $Environment" -ForegroundColor Gray
Write-Host "Location: $Location" -ForegroundColor Gray

if ($WhatIf) {
    Write-Host "(Running in WhatIf mode - no resources will be created)" -ForegroundColor Cyan
    Write-Host ""
}

$deployCmd = @(
    'deployment', 'group', 'create',
    '--name', $deploymentName,
    '--resource-group', $ResourceGroupName,
    '--template-file', $bicepFile,
    '--parameters', $paramFile
)

if ($WhatIf) {
    $deployCmd += '--what-if'
}

Write-Host ""
$deploymentOutput = az @deployCmd

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Deployment failed" -ForegroundColor Red
    Write-Host $deploymentOutput
    exit 1
}

Write-Host "✅ Deployment completed successfully" -ForegroundColor Green
Write-Host ""

# ============================================================================
# Output
# ============================================================================

Write-Host "📊 Deployment Outputs:" -ForegroundColor Yellow
Write-Host ""

$outputs = az deployment group show --resource-group $ResourceGroupName --name $deploymentName --query "properties.outputs" -o json | ConvertFrom-Json

foreach ($key in $outputs.PSObject.Properties.Name) {
    $value = $outputs.$key.value
    Write-Host "$($key): $value" -ForegroundColor Green
}

Write-Host ""
Write-Host "═══════════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "Deployment completed!" -ForegroundColor Green
Write-Host "═══════════════════════════════════════════════════════════════════" -ForegroundColor Cyan

# ============================================================================
# Next Steps
# ============================================================================

Write-Host ""
Write-Host "📝 Next Steps:" -ForegroundColor Yellow
Write-Host "1. Review the deployed resources in Azure Portal"
Write-Host "2. Deploy your application package to App Service:"
Write-Host "   az webapp deployment source config-zip --resource-group $ResourceGroupName --name <app-service-name> --src app.zip"
Write-Host "3. Monitor application health in Application Insights"
Write-Host "4. Test the application at the deployed URL"
Write-Host ""

exit 0
