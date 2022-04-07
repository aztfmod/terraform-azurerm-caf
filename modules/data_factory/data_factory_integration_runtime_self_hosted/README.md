module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# data_factory_integration_runtime_self_hosted

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|data_factory|The `data_factory` block as defined below.|Block|True|
|name| The name which should be used for this Data Factory. Changing this forces a new Data Factory Self-hosted Integration Runtime to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|data_factory| key | Key for  data_factory||| Required if  |
|data_factory| lz_key |Landing Zone Key in wich the data_factory is located|||True|
|data_factory| name | The name of the data_factory |||True|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Data Factory.|||
|auth_key_1|The primary integration runtime authentication key.|||
|auth_key_2|The secondary integration runtime authentication key.|||
