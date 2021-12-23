module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# servicebus_namespace

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the ServiceBus Namespace resource . Changing this forces a||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
| region |The region_key where the resource will be deployed|String|True|
|sku| Defines which tier to use. Options are basic, standard or premium. Changing this forces a new resource to be created.||True|
|capacity| Specifies the capacity. When `sku` is `Premium`, capacity can be `1`, `2`, `4`, `8` or `16`. When `sku` is `Basic` or `Standard`, capacity can be `0` only.||False|
|zone_redundant| Whether or not this resource is zone redundant. `sku` needs to be `Premium`. Defaults to `false`.||False|
|tags| A mapping of tags to assign to the resource.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ServiceBus Namespace ID.|||
|default_primary_connection_string|The primary connection string for the authorization|||
|default_secondary_connection_string|The secondary connection string for the|||
|default_primary_key|The primary access key for the authorization rule `RootManageSharedAccessKey`.|||
|default_secondary_key|The secondary access key for the authorization rule `RootManageSharedAccessKey`.|||
