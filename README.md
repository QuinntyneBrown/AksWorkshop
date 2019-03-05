# Introduction 
AKS workshop demo files. Master branch has final code. Go to specific TAG to find "starting points for the lab"

## Tag 00-Start

Contains startup code: apis + web + compose.

**Goal**: Create YAML Kubernetes files to create 4 deployments and 4 services. Website should be exposed using `LoadBalancer` service.

**Steps**

1. Create Azure resources: AKS & ACR
2. Build & Push images on the ACR
3. Add `acr-key` secret with ACR credentials to AKS
4. Create the YAML files and deploy on AKS
5. Test it!

## Tag 01-scripts-v1

Contains the basic scripts to deploy everything on Kubernetes, using `LoadBalancer` service to expose the web.

**Goal**: Create ingress resource to expose web witn `/` and also apis (to allow test with swagger). APIs should be exposed at `/order-api`, `/basket-api` and `/catalog-api`.

**Steps**

1. Add ingress YAML file, using Http addon host value
2. Take care about base path issues

## Tag 02-Ingress

Contains the ingress definitions and services adapted to honour base path. 

**Goal**: Enable SSL through cert-manager

**Steps**

1. Install tiller on cluster & use helm to install cert-manager
2. Generate a issuer & certificate using let's encrypt staging
3. Update ingress definition to enable TLS
4. Verify https endpoints have let's encrypt staging cert
5. Generate a issuer & certificate using let's encrypt prod (**Note**: That can fail due to Let's Encrypt limits)
6. Update ingress to use new certificate
7. Verify site works on https with no issues 

## Tag 03-SSL

Contains the SSL setup (using staging certs)

**Goal** Change the scripts to use Helm charts instead of YAML files

**Steps**

1. Create helm charts for every service
2. Deploy them all

## Tag 04-Helm.

Contains the Helm charts

**Goal** Integrate with ACR with no need to use `imagePullSecrets`

**Steps**

1. Link _service principal_ to ACR and to _service account_
2. Use the service account to run the pods (update helm charts)

## Tag 05-acr-sa

Contains the ACR and sa scripts & helm charts updated

**Goal** Use k8s secrets fot storing constr instead of standard configmaps

1. Update helm charts to use secrets
2. Redeploy

## Tag 06-k8s-secrets

Contains using k8s secrets instead of configmaps

**Goal** Do a real secret management using Azure Key Vault

1. Update helm charts to remove the secrets
2. Create a key vault
3. Mount volumes from key vault
4. Update code to read volumes

## Tag 07-Keyvault

Contains KeyVault scripts & updated code

**Goal** Set HPA scalability

1. Update helm charts to put pod limits
2. Add HPA scripts

## Tag 08-hpa

Contains HPA scripts & charts updated to use CPU pod limits

**Goal** Use virtual nodes

1. Create a AKS with virtual nodes enabled
2. Add a new secret to access ACR (ACR auth must be enabled)
4. Update helm charts (avoid using Key Vault and ACR _service account_ as is not supported)





