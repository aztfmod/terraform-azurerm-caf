module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# purview_accounts

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| region |The region_key where the resource will be deployed|String|True|
|name| The name which should be used for this Purview Account. Changing this forces a new Purview Account to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|public_network_enabled| Should the Purview Account be visible to the public network? Defaults to `true`.||False|
|managed_resource_group_name| The name which should be used for the new Resource Group where Purview Account creates the managed resources. Changing this forces a new Purview Account to be created.||False|
|managed_resource_group_name| The name which should be used for the new Resource Group where Purview Account creates the managed resources. Changing this forces a new Purview Account to be created.||False|
|tags| A mapping of tags which should be assigned to the Purview Account.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Purview Account.|||
|atlas_kafka_endpoint_primary_connection_string|Atlas Kafka endpoint primary connection string.|||
|atlas_kafka_endpoint_secondary_connection_string|Atlas Kafka endpoint secondary connection string.|||
|catalog_endpoint|Catalog endpoint.|||
|guardian_endpoint|Guardian endpoint.|||
|scan_endpoint|Scan endpoint.|||
|identity|A `identity` block as defined below.|||
|managed_resources|A `managed_resources` block as defined below.|||
