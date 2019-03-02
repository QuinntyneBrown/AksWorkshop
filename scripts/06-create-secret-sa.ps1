Param(
    [parameter(Mandatory=$true)][string]$resourceGroup,
    [parameter(Mandatory=$true)][string]$acrName,
    [parameter(Mandatory=$true)][string]$clientId,
    [parameter(Mandatory=$true)][string]$password
)

Write-Host "--------------------------------------------------------" -ForegroundColor Green
Write-Host "Deploying secret for accessing ACR" -ForegroundColor Green
Write-Host "Additional parameters are: " -ForegroundColor Green
Write-Host "ACR $acrName in RG $resourceGroup " -ForegroundColor Green
Write-Host "Client Id: $clientId with pwd: $password " -ForegroundColor Green
Write-Host "-------------------------------------------------------- " -ForegroundColor Green

$acrLogin=$(az acr show -n $acrName -g $resourceGroup | ConvertFrom-Json).loginServer
$acrId=$(az acr show -n $acrName -g $resourceGroup | ConvertFrom-Json).id

Write-Host "Assigning 'reader' role to $clientId to $acrName" -ForegroundColor Green
az role assignment create --assignee $clientId --scope $acrId --role reader

Write-Host "Deleting old acr-key secret" -ForegroundColor Green
kubectl delete secret acr-key

Write-Host "Disabling auth access to ACR" -ForegroundColor Green
az acr update -n $acrName -g $resourceGroup --admin-enabled $false

Write-Host "Creating NEW acr-key secret" -ForegroundColor Green
kubectl create secret docker-registry acr-key --docker-server $acrLogin --docker-username $clientId --docker-password $password --docker-email not@used.com

Write-Host "Deploying ServiceAccount acrsa" -ForegroundColor Green
kubectl apply -f helm/sa.yaml 