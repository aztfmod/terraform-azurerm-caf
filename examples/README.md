# Cloud Adoption Framework for Azure - Terraform module examples

Getting started with examples, once you have cloned this repository locally

## Deploying examples with Terraform

Each module can be deployed outside of the rover using native Terraform.

You can instantiate this directly using the following syntax:

```hcl
module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
  # insert the 7 required variables here
}
```

Please refer to the instructions within each example directory, whenever you have a /standalone subdirectory.


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

## Using the examples

You can customize the examples execution by modifying the variables as follow:

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| azuread | ~> 1.0.0 |
| azurecaf | ~> 1.1.0 |
| azurerm | ~> 2.47.0 |
| external | ~> 1.2.0 |
| null | ~> 2.1.0 |
| random | ~> 2.2.1 |
| time | ~> 0.6.0 |
| tls | ~> 2.2.0 |

## Providers

| Name | Version |
|------|---------|
| terraform | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aks\_clusters | n/a | `map` | `{}` | no |
| app\_service\_environments | n/a | `map` | `{}` | no |
| app\_service\_plans | n/a | `map` | `{}` | no |
| app\_services | n/a | `map` | `{}` | no |
| application\_gateway\_applications | n/a | `map` | `{}` | no |
| application\_gateways | n/a | `map` | `{}` | no |
| automations | n/a | `map` | `{}` | no |
| availability\_sets | n/a | `map` | `{}` | no |
| azuread\_apps | n/a | `map` | `{}` | no |
| azuread\_groups | n/a | `map` | `{}` | no |
| azuread\_roles | n/a | `map` | `{}` | no |
| azuread\_users | n/a | `map` | `{}` | no |
| azure\_devops\_projects | n/a | `map` | `{}` | no |
| azurerm\_application\_insights | n/a | `map` | `{}` | no |
| azurerm\_firewall\_application\_rule\_collection\_definition | n/a | `map` | `{}` | no |
| azurerm\_firewall\_nat\_rule\_collection\_definition | n/a | `map` | `{}` | no |
| azurerm\_firewall\_network\_rule\_collection\_definition | n/a | `map` | `{}` | no |
| azurerm\_firewalls | n/a | `map` | `{}` | no |
| azurerm\_redis\_caches | n/a | `map` | `{}` | no |
| azurerm\_routes | n/a | `map` | `{}` | no |
| bastion\_hosts | n/a | `map` | `{}` | no |
| cosmos\_db | n/a | `map` | `{}` | no |
| cosmos\_dbs | n/a | `map` | `{}` | no |
| custom\_role\_definitions | n/a | `map` | `{}` | no |
| databricks\_workspaces | n/a | `map` | `{}` | no |
| diagnostic\_event\_hub\_namespaces | n/a | `map` | `{}` | no |
| diagnostic\_log\_analytics | n/a | `map` | `{}` | no |
| diagnostic\_storage\_accounts | n/a | `map` | `{}` | no |
| diagnostics\_definition | n/a | `any` | `null` | no |
| diagnostics\_destinations | n/a | `map` | `{}` | no |
| dns\_zone\_records | n/a | `map` | `{}` | no |
| dns\_zones | n/a | `map` | `{}` | no |
| domain\_name\_registrations | n/a | `map` | `{}` | no |
| dynamic\_keyvault\_secrets | n/a | `map` | `{}` | no |
| environment | n/a | `string` | `"sandpit"` | no |
| event\_hub\_namespaces | n/a | `map` | `{}` | no |
| express\_route\_circuit\_authorizations | n/a | `map` | `{}` | no |
| express\_route\_circuits | n/a | `map` | `{}` | no |
| front\_door\_waf\_policies | n/a | `map` | `{}` | no |
| front\_doors | n/a | `map` | `{}` | no |
| global\_settings | n/a | `map` | <pre>{<br>  "default_region": "region1",<br>  "regions": {<br>    "region1": "southeastasia",<br>    "region2": "eastasia"<br>  }<br>}</pre> | no |
| keyvault\_access\_policies | n/a | `map` | `{}` | no |
| keyvault\_certificate\_issuers | n/a | `map` | `{}` | no |
| keyvault\_certificate\_requests | n/a | `map` | `{}` | no |
| keyvault\_keys | n/a | `map` | `{}` | no |
| keyvaults | n/a | `map` | `{}` | no |
| landingzone | n/a | `map` | <pre>{<br>  "backend_type": "azurerm",<br>  "global_settings_key": "launchpad",<br>  "key": "examples",<br>  "level": "level0",<br>  "tfstates": {<br>    "launchpad": {<br>      "level": "lower",<br>      "tfstate": "caf_launchpad.tfstate"<br>    }<br>  }<br>}</pre> | no |
| local\_network\_gateways | n/a | `map` | `{}` | no |
| log\_analytics | n/a | `map` | `{}` | no |
| logged\_aad\_app\_objectId | n/a | `any` | `null` | no |
| logged\_user\_objectId | n/a | `any` | `null` | no |
| lower\_container\_name | n/a | `any` | n/a | yes |
| lower\_resource\_group\_name | n/a | `any` | n/a | yes |
| lower\_storage\_account\_name | Map of the remote data state for lower level | `any` | n/a | yes |
| machine\_learning\_workspaces | n/a | `map` | `{}` | no |
| managed\_identities | n/a | `map` | `{}` | no |
| mariadb\_databases | n/a | `map` | `{}` | no |
| mariadb\_servers | n/a | `map` | `{}` | no |
| monitoring | n/a | `map` | `{}` | no |
| mssql\_databases | n/a | `map` | `{}` | no |
| mssql\_elastic\_pools | n/a | `map` | `{}` | no |
| mssql\_failover\_groups | n/a | `map` | `{}` | no |
| mssql\_managed\_databases | n/a | `map` | `{}` | no |
| mssql\_managed\_databases\_backup\_ltr | n/a | `map` | `{}` | no |
| mssql\_managed\_databases\_restore | n/a | `map` | `{}` | no |
| mssql\_managed\_instances | n/a | `map` | `{}` | no |
| mssql\_managed\_instances\_secondary | n/a | `map` | `{}` | no |
| mssql\_mi\_administrators | n/a | `map` | `{}` | no |
| mssql\_mi\_failover\_groups | n/a | `map` | `{}` | no |
| mssql\_mi\_secondary\_tdes | n/a | `map` | `{}` | no |
| mssql\_mi\_tdes | n/a | `map` | `{}` | no |
| mssql\_servers | n/a | `map` | `{}` | no |
| mysql\_servers | n/a | `map` | `{}` | no |
| netapp\_accounts | n/a | `map` | `{}` | no |
| network\_security\_group\_definition | n/a | `any` | `null` | no |
| network\_watchers | n/a | `map` | `{}` | no |
| postgresql\_servers | n/a | `map` | `{}` | no |
| private\_dns | n/a | `map` | `{}` | no |
| private\_endpoints | n/a | `map` | `{}` | no |
| proximity\_placement\_groups | n/a | `map` | `{}` | no |
| public\_ip\_addresses | n/a | `map` | `{}` | no |
| recovery\_vaults | n/a | `map` | `{}` | no |
| resource\_groups | n/a | `any` | `null` | no |
| role\_mapping | n/a | `map` | `{}` | no |
| route\_tables | n/a | `map` | `{}` | no |
| rover\_version | n/a | `any` | `null` | no |
| storage\_accounts | n/a | `map` | `{}` | no |
| synapse\_workspaces | n/a | `map` | `{}` | no |
| tags | n/a | `map` | `null` | no |
| tenant\_id | n/a | `any` | n/a | yes |
| tfstate\_container\_name | n/a | `any` | n/a | yes |
| tfstate\_key | n/a | `any` | n/a | yes |
| tfstate\_resource\_group\_name | n/a | `any` | n/a | yes |
| tfstate\_storage\_account\_name | n/a | `any` | n/a | yes |
| tfstate\_subscription\_id | n/a | `any` | n/a | yes |
| var\_folder\_path | n/a | `map` | `{}` | no |
| virtual\_machines | n/a | `map` | `{}` | no |
| virtual\_network\_gateway\_connections | n/a | `map` | `{}` | no |
| virtual\_network\_gateways | n/a | `map` | `{}` | no |
| virtual\_wans | n/a | `map` | `{}` | no |
| vnet\_peerings | n/a | `map` | `{}` | no |
| vnets | n/a | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| dns\_zone\_records | n/a |
| dns\_zones | n/a |
| keyvault\_certificate\_requests | n/a |
| keyvault\_certificates | n/a |
| mssql\_managed\_instances | n/a |
| mssql\_managed\_instances\_secondary | n/a |
| virtual\_machines | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->