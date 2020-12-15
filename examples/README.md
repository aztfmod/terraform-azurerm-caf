[![VScodespaces](https://img.shields.io/endpoint?url=https%3A%2F%2Faka.ms%2Fvso-badge)](https://online.visualstudio.com/environments/new?name=terraform-azurerm-caf-landingzone-modules&repo=aztfmod/terraform-azurerm-caf)

# Cloud Adoption Framework for Azure - Terraform module examples

Getting started with examples, once you have cloned this repository locally


## Deploying examples with rover

To get started with the deployment within rover, follow the steps:

1. Log in the subscription with the rover

```bash
rover login
### you can alternatively specify the tenant space and subscription ID on command line arguments:
rover login --tenant <tenant_name>.onmicrosoft.com -s <subscription_id>
```


2. Deploy the basic launchpad

```bash
rover -lz /tf/caf/public/landingzones/caf_launchpad \
-launchpad \
-var-folder /tf/caf/public/landingzones/caf_launchpad/scenario/100 \
-a apply
```

3. Test your example

```bash
rover -lz /tf/caf/examples \
-var-folder /tf/caf/examples/<path of the example> \
-a plan|apply
```

rover -lz /tf/caf/examples \
-var-folder /tf/caf//tf/caf/examples/mssql_mi/200-mi-two-regions \
-a plan|apply


## Developing and testing module for landing zones

Use those instructions only if you want to test, and develop features for landing zones with this module. You will need to add landing zones locally:

1. Clone the Azure landing zones repo

```bash
git clone --branch <public_version_you_want_to_use> https://github.com/Azure/caf-terraform-landingzones.git /tf/caf/public
```

This will clone the logic of landing zones in your local repository without committing your landing zones changes (we have put for you a filter on /public for landing zones.)

2. Change the module path in your landing zone

By default the landing zone will source the module from the registry.

For each landing zone you want to edit, go to the ```landingzone.tf``` file:

```
module "networking" {
  source  = "aztfmod/caf/azurerm"
  version = "~> 0.4"
```

You can replace it with your local path, typically here:

```
module "networking" {
  source  = "../../.."
```

You should now be able to run landing zones as usual, except it will source the module locally, so you can test the features you introduced in the module.