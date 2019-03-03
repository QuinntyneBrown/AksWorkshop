Param(
    [parameter(Mandatory=$true)][string]$resourceGroup,
    [parameter(Mandatory=$true)][string]$keyvaultName,
    [parameter(Mandatory=$true)][string]$secretName,
    [parameter(Mandatory=$true)][string]$secretValue
)

$kv = $(az keyvault show -n $keyvaultName -g $resourceGroup) | ConvertFrom-Json

if ($null -eq $kv) {
    Write-Host "Error: Keyvault $keyvaultName not found in RG $resourceGroup" -ForegroundColor Red
    exit 1
}

az keyvault secret set --vault-name $keyvaultName -n $secretName --value "$secretValue"
Write-Host "Set secret $secretName with value $secretValue in keyvault $keyvaultName" -ForegroundColor Green