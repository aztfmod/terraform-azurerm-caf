# Azure Database Migration Services and Projects

This module is part of Cloud Adoption Framework landing zones for Azure on Terraform.

For an overview of the service, please refer to [Azure documentation](https://azure.microsoft.com/en-us/services/database-migration/#overview)

## Example scenarios

The following examples are available:

| Scenario                                                     | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [100-dms](./100-dms)     | Simple example to create a database migration service and an associated projects. |

You can instantiate this directly using the following parameters:

```hcl
module "caf" {
source  = "aztfmod/caf/azurerm"
version = "5.4.3"

#pass the required variables
}
```

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
  -var-file ../modules/databases/database_migration_service/examples/100-dms/configuration.tfvars
```

### With rover

To test this deployment in the example landingzone, make sure the launchpad has been deployed first, then run the following command:

```bash
rover \
  -lz /tf/caf/examples \
  -var-folder ../modules/databases/database_migration_service/examples/100-dms \
  -level level1 \
  -a [plan | apply | destroy]
```