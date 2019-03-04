Param(
    [parameter(Mandatory=$false)][string]$baseName="my",
    [parameter(Mandatory=$false)][string]$imageTag="latest"
)

cmd /c "helm upgrade $baseName-basket .\basket-api"
cmd /c "helm upgrade $baseName-order .\order-api"
cmd /c "helm upgrade $baseName-catalog .\catalog-api"
cmd /c "helm upgrade $baseName-website .\website"