
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
rover -lz /tf/caf -var-file /tf/caf/modules/terraform-azurerm-caf-asp/examples/windows_container/configuration.tfvars -a apply
```
