
# Pre-requisites
You need to deploy the launchpad with advanced state management. You can check the configurations on the landingzones/caf_launchpad/examples/40x folders

```bash
rover -lz /tf/caf/landingzones/caf_launchpad -var-file /tf/caf/landingzones/caf_launchpad/examples/40xxxx.tfvars -launchpad -a apply
```

# Examples

## Deploy a dedicated app service plan

Deploys
* A resource group in the default region
* A Windows app service place dedicated

```bash
rover -lz /tf/caf -var-file /tf/caf/modules/terraform-azurerm-caf-ase/examples/single-ase-internal/configuration.tfvars -a apply
```
