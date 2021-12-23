module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# recovery_services_vault

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the Recovery Services Vault. Recovery Service Vault name must be 2 - 50 characters long, start with a letter, contain only letters, numbers and hyphens. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
| region |The region_key where the resource will be deployed|String|True|
|tags| A mapping of tags to assign to the resource.||False|
|identity| An `identity` block as defined below. | Block |False|
|sku| Sets the vault's SKU. Possible values include: `Standard`, `RS0`.||True|
|storage_mode_type| The storage type of the Recovery Services Vault. Possible values are `GeoRedundant` and `LocallyRedundant`. Defaults to `GeoRedundant`.||False|
|soft_delete_enabled| Is soft delete enable for this Vault? Defaults to `true`.||False|
|type| The Type of Identity which should be used for this Recovery Services Vault. At this time the only possible value is `SystemAssigned`.||True|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|identity|type| The Type of Identity which should be used for this Recovery Services Vault. At this time the only possible value is `SystemAssigned`.|||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Recovery Services Vault.|||
