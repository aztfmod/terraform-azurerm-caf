module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# data_factory_linked_service_azure_databricks

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|adb_domain| The domain URL of the databricks instance.||True|
|data_factory|The `data_factory` block as defined below.|Block|True|
|name| Specifies the name of the Data Factory Linked Service. Changing this forces a new resource to be created. Must be unique within a data factory. See the [Microsoft documentation](https://docs.microsoft.com/en-us/azure/data-factory/naming-rules) for all restrictions.||True|
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
|id|The ID of the Data Factory Linked Service.|||
