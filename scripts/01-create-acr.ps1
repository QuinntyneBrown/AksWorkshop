Param(
    [parameter(Mandatory=$true)][string]$resourceGroup,
    [parameter(Mandatory=$true)][string]$name
)

$group = $(az group show -n $resourceGroup)

if ($null -eq $group) {
    az group create -n $resourceGroup -l westeurope
}

az acr create -n $name -g $resourceGroup --admin-enabled true --sku standard

Write-Host "ACR $name in group $resourceGroup created" -ForegroundColor Green