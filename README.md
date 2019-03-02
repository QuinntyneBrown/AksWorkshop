# Introduction 
AKS workshop demo files. Master branch has final code. Go to specific TAG to find "starting points for the lab"

## Tag 00-Start (From docker to k8s)

Contains startup code: apis + web + compose.

**Goal**: Create YAML Kubernetes files to create 4 deployments and 4 services. Website should be exposed using `LoadBalancer` service.

**Steps**

1. Create Azure resources: AKS & ACR
2. Build & Push images on the ACR
3. Add `acr-key` secret with ACR credentials to AKS
4. Create the YAML files and deploy on AKS
5. Test it!

## Tag 01-script-v1 (Exposing services through ingress)

Contains the basic scripts to deploy everything on Kubernetes, using `LoadBalancer` service to expose the web.

**Goal**: Create ingress resource to expose web witn `/` and also apis (to allow test with swagger). APIs should be exposed at `/order-api`, `/basket-api` and `/catalog-api`.

**Steps**

1. Add ingress YAML file, using Http addon host value
2. Take care about base path issues

## Tag 02-Ingress (Enable SSL)

Contains the ingress definitions and services adapted to honour base path. 

**Goal**: Enable SSL through cert-manager

**Steps**

1. Install tiller on cluster & use helm to install cert-manager
2. Generate a issuer & certificate using let's encrypt staging
3. Update ingress definition to enable TLS
4. Verify https endpoints have let's encrypt staging cert
5. Generate a issuer & certificate using let's encrypt prod
6. Update ingress to use new certificate
7. Verify site works on https with no issues



