
# Pre-requisites
You need to deploy at minimum the launchpad light for the remote state management

```bash

```

# Examples

## Deploy a dedicated app service plan

Deploys
* A resource group in the default region
* A Windows app service place dedicated

```bash
rover -lz /tf/caf/modules/terraform-azurerm-caf-asp/examples/ -var-file /tf/caf/modules/terraform-azurerm-caf-asp/examples/dedicated/configuration.tfvars -tfstate example_asp_dedicated.tfstate -a apply
```
