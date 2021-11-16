# Azure Database Migration Services and Projects

This module is part of Cloud Adoption Framework landing zones for Azure on Terraform.

For an overview of the service, please refer to [Azure documentation](https://azure.microsoft.com/en-us/services/database-migration/#overview)

## Example scenarios

The following examples are available:

| Scenario                                                     | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [100-dms](./examples/database_migration_services)     | Simple example to create a database migration service and an associated projects. |

You can instantiate this directly using the following parameters:

```hcl
module "caf" {
source  = "aztfmod/caf/azurerm"
version = "5.4.3"

  #pass the required variables
}
```

## Reference parameters

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_base_tags"></a> [base\_tags](#input\_base\_tags) | Base tags for the resource to be inherited from the resource group. | `map(any)` | n/a | yes |
| <a name="input_client_config"></a> [client\_config](#input\_client\_config) | Client configuration object (see module README.md). | `any` | n/a | yes |
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object (see module README.md) | `any` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_remote_objects"></a> [remote\_objects](#input\_remote\_objects) | Combined objects for virtual networks used in the module. | `map(any)` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the resource group where to create the resource. | `string` | n/a | yes |
| <a name="input_settings"></a> [settings](#input\_settings) | Configuration object for the database migration service. Refer to documentation for details. | `any` | n/a | yes |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

### Settings details

The settings object is a map of maps containing the following attributes:

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Specify the name of the database migration service. Changing this forces a new resource to be created. | String | n/a | Yes |
| resource_group_key | Specify the key of the resource group where to deploy the service. Changing this forces a new resource to be created. | String | n/a | Yes |
| region | Specify the region of the database migration service. Changing this forces a new resource to be created. | String | n/a | Yes |
| sku_name | The sku name of the database migration service. Possible values are ```Premium_4vCores```, ```Standard_1vCores```, ```Standard_2vCores``` and ```Standard_4vCores```. Changing this forces a new resource to be created. | String | n/a | Yes |
| subnet | Specify the subnet configuration object as described below. | String | n/a | Yes |

### Subnet details

You can specify the subnets details either calling it via its Azure resource identifier (```subnet_id```) or via the composition model (```vnet_key```, ```subnet_key``` and ```lz_key```) if created inside this module.

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| vnet_key | The key of the virtual network. | String | n/a | No |
| subnet_key | The key of the subnet. | String | n/a | No |
| lz_key | The key of the remote landing zone for the virtual network. This key should be populated only if the virtual network object is composed from a remote landing zone. | String | n/a | No |
| subnet_id | The ID of the virtual subnet resource to which the database migration service should be joined. Changing this forces a new resource to be created. | String | n/a | No |


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