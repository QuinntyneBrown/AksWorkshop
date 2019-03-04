Param(
    [parameter(Mandatory=$true)][string]$resourceGroup,
    [parameter(Mandatory=$true)][string]$aksName,
    [parameter(Mandatory=$false)][string]$userName="defaultUser"
)

$aks = $(az aks show -g $resourceGroup -n $aksName) | ConvertFrom-Json

if ($null -eq $aks) {
    Write-Host "No AKS $aksName found in RG $resourceGroup" -ForegroundColor Red
    exit 1
}

$hostName = $aks.addonProfiles.httpApplicationRouting.config.HTTPApplicationRoutingZoneName

$requestUrl="http://$hostName/basket-api/api/Basket/$userName"

Write-Host "Beginning infinite loop to request $requestUrl" -ForegroundColor Green

for (;;) {
    Invoke-WebRequest -Uri $requestUrl -UseBasicParsing | Out-Null
    Write-Host "." -NoNewline -ForegroundColor Green
}