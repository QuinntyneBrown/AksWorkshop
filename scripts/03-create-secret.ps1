Param(
    [parameter(Mandatory=$true)][string]$resourceGroup,
    [parameter(Mandatory=$true)][string]$acrName,
    [parameter(Mandatory=$false)][string]$secretName="acr-key"
)

$acr = $(az acr show -n $acrName -g $resourceGroup) | ConvertFrom-Json

if ($null -eq $acr) {
    Write-Host "FATAL: ACR $acr not found in RG $resourceGroup" -ForegroundColor Red
    exit 1
}

$loginServer=$acr.loginServer

$credentials = $(az acr credential show -n $acrName -g $resourceGroup) | ConvertFrom-Json

$username = $credentials.username
$password = $credentials.passwords[0].value

kubectl delete secret $secretName
kubectl create secret docker-registry $secretName --docker-server=$loginServer --docker-username=$username --docker-password=$password --docker-email="not@used.com"

Write-Host "Secret created for $loginServer with login value of $username and password $password" -ForegroundColor Green