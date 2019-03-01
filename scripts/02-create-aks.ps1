Param(
    [parameter(Mandatory=$true)][string]$resourceGroup,
    [parameter(Mandatory=$true)][string]$name,
    [parameter(Mandatory=$false)][string]$vmsize="Standard_DS2_v2",
    [parameter(Mandatory=$false)][int]$nodeCount=3,
    [parameter(Mandatory=$false)][string]$version="1.12.5"
)

$group = $(az group show -n $resourceGroup)

if ($null -eq $group) {
    az group create -n $resourceGroup -l westeurope
}

$sp = $(az ad sp create-for-rbac -n "http://sp-$name") | ConvertFrom-Json

Write-Host "-------------------------------------------------" -ForegroundColor White
Write-Host "Please save these values for future use:"
Write-Host "AppId (Client Id)" $sp.appId
Write-Host "Password         " $sp.password
Write-Host "-------------------------------------------------" -ForegroundColor White

az aks create -n $name -g $resourceGroup -a http_application_routing,monitoring -s $vmSize -c $nodeCount -k $version --service-principal $sp.appId --client-secret $sp.password

Write-Host "AKS $name in group $resourceGroup created ($nodeCount $vmsize nodes)" -ForegroundColor Green

az aks get-credentials -n $name -g $resourceGroup