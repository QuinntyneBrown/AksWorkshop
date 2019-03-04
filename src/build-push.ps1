Param(
    [parameter(Mandatory=$true)][string]$resourceGroup,
    [parameter(Mandatory=$true)][string]$acrName,
    [parameter(Mandatory=$false)][string]$tag="latest",
    [parameter(Mandatory=$false)][bool]$build=$true
)

$acr=$(az acr show -n $acrName -g $resourceGroup) | ConvertFrom-Json

if ($null -eq $acr) {
    Write-Host "Error: ACR $acrName not found in $resourceGroup $resourceGroup" -ForegroundColor Red
    exit 1
}

$loginServer=$acr.loginServer
$adminUserEnabled = $acr.adminUserEnabled

if ($adminUserEnabled -eq $false) {
    Write-Host "ACR $acrName has admin login disabled. We will re-enable it for allowing the push" -ForegroundColor Yellow
    az acr update -n $acrName -g $resourceGroup --admin-enabled $true
}

Write-Host "Reading credentials of ACR $acrName and perform a docker login to ensure push rights..." -ForegroundColor Green
$credentials = $(az acr credential show -n $acrName -g $resourceGroup) | ConvertFrom-Json
$username = $credentials.username
$password = $credentials.passwords[0].value
Write-Host "Credentials of ACR $acrName are $username with pwd $password" -ForegroundColor Green
docker login $loginServer -u $username -p $password

if ($build -eq $true) {
    Write-Host "Doing a docker build" -ForegroundColor Green
    docker-compose build
}

Write-Host "Doing the push using compose" -ForegroundColor Green
$Env:TAG=$tag
$Env:REGISTRY=$loginServer
docker-compose push
Write-Host "Push complete!" -ForegroundColor Green

if ($adminUserEnabled -eq $false) {
    Write-Host "ACR $acrName had admin login disabled. We will re-disable them." -ForegroundColor Yellow
    az acr update -n $acrName -g $resourceGroup --admin-enabled $false
    Write-Host "ACR $acrName has admin login disabled again." -ForegroundColor Yellow
}









