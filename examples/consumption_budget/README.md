# Azure consumption_budget Resources

This module is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this directly using the following parameters:

```hcl
module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "~>5.5.0"

  # Add object as described below
}
```

CAF Terraform module is iterative by default, you can instantiate as many objects as needed, using the following structure:

```hcl
resource_to_be_created = {
  object1 = {
    #configuration details as below
  }
  object2 = {
    #configuration details as below
  }
}
```

## Example scenarios

The following examples are available:

| Scenario                                                     | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [100-consumption-budget-rg](./100-consumption-budget-rg)     | Simple example for consumption budget deployed at resource group scope. |
| [101-consumption-budget-subscription](./101-consumption-budget-subscription) | Simple example for consumption budget deployed at subscription scope. |
| [102-consumption-budget-rg-alerts](./102-consumption-budget-rg-alerts) | Simple example for consumption budget deployed at resource group scope, integrated with action groups. |
| [103-consumption-budget-subscription-alerts](./103-consumption-budget-subscription-alerts) | Simple example for consumption budget deployed at subscription scope, integrated with action groups. |
| [104-consumption-budget-subscription-vm](./104-consumption-budget-subscription-vm) | Consumption budget deployed at subscription scope, integrated with Azure windows virtual machine. |
| [105-consumption-budget-subscription-aks](./105-consumption-budget-subscription-vm) | Consumption budget deployed at subscription scope, integrated with Azure Kubernetes Service single cluster |

## Run this example

You can run this example directly using Terraform or via rover:

### With Terraform

```bash
#Login to your Azure subscription
az login

#Run the example
cd /tf/caf/examples

terraform init

terraform [plan | apply | destroy] \
  -var-file ./consumption_budget/102-consumption-budget-rg-alerts/configuration.tfvars
```

### With rover

To test this deployment in the example landingzone, make sure the launchpad has been deployed first, then run the following command:

```bash
rover \
  -lz /tf/caf/examples \
  -var-folder  /tf/caf/examples/consumption_budget/102-consumption-budget-rg-alerts/ \
  -level level1 \
  -a [plan | apply | destroy]
```