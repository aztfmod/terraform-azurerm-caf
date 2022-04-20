module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# relay_namespace

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the Azure Relay Namespace. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
| region |The region_key where the resource will be deployed|String|True|
|sku_name| The name of the SKU to use. At this time the only supported value is `Standard`.||True|
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
|id|The Azure Relay Namespace ID.|||
|primary_connection_string|The primary connection string for the authorization rule `RootManageSharedAccessKey`.|||
|secondary_connection_string|The secondary connection string for the authorization rule `RootManageSharedAccessKey`.|||
|primary_key|The primary access key for the authorization rule `RootManageSharedAccessKey`.|||
|secondary_key|The secondary access key for the authorization rule `RootManageSharedAccessKey`.|||
|metric_id|The Identifier for Azure Insights metrics.|||
