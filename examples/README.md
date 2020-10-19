[![VScodespaces](https://img.shields.io/endpoint?url=https%3A%2F%2Faka.ms%2Fvso-badge)](https://online.visualstudio.com/environments/new?name=terraform-azurerm-caf-landingzone-modules&repo=aztfmod/terraform-azurerm-caf)

# Cloud Adoption Framework for Azure - Terraform module examples

## Developing and testing module for landing zones

If you want to test, develop this module for landing zones integration, please follow the steps:

1. Clone the Azure landing zones repo

```bash
git clone --branch 0.4 https://github.com/Azure/caf-terraform-landingzones.git /tf/caf/public
```

2. Log in the subscription with the rover

```bash
rover login
### you can alternatively specify the tenant space and subscription ID on command line arguments:
rover login --tenant <tenant_name>.onmicrosoft.com -s <subscription_id>
```

3. Deploy the basic launchpad

```bash
rover -lz /tf/caf/public/landingzones/caf_launchpad \
-launchpad \
-var-folder /tf/caf/public/landingzones/caf_launchpad/scenario/100 \
-a apply
```

## Deploying examples

Once you have setup the environment up to stage 3 (have finished the deployment of the launchpad), you can deploy examples using the following syntax:

```bash
rover -lz /tf/caf/examples \
-var-folder /tf/caf/examples/<path of the example> \
-a plan|apply
```

We categorize the various examples in this repo as follow:

| level | functionalities                                                                               | supported environments                     |
|-------|-----------------------------------------------------------------------------------------------|--------------------------------------------|
| 100   | basic functionalities and features, no RBAC or security hardening - for demo and simple POC   | working on AIRS subscriptions              |
| 200   | intermediate functionalities includes RBAC features                                           | may not work in AIRS, need AAD permissions |
| 300   | advanced functionalities, multi region support, includes RBAC features                        | not working in AIRS, need AAD permissions  |
| 400   | advanced functionalities, multi region support, includes RBAC features and security hardening | not working in AIRS, need AAD permissions  |
