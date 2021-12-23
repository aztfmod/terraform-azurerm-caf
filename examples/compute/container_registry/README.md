module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# container_registry

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the Container Registry. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
| region |The region_key where the resource will be deployed|String|True|
|admin_enabled| Specifies whether the admin user is enabled. Defaults to `false`.||False|
|sku| The SKU name of the container registry. Possible values are  `Basic`, `Standard` and `Premium`. `Classic` (which was previously `Basic`) is supported only for existing resources.||False|
|tags| A mapping of tags to assign to the resource.||False|
|georeplication_locations| A list of Azure locations where the container registry should be geo-replicated.||False|
|georeplications| A `georeplications` block as documented below.||False|
|network_rule_set| A `network_rule_set` block as documented below.||False|
|public_network_access_enabled| Whether public network access is allowed for the container registry. Defaults to `true`.||False|
|quarantine_policy_enabled| Boolean value that indicates whether quarantine policy is enabled. Defaults to `false`.||False|
|regional_endpoint_enabled| Whether regional endpoint is enabled for this Container Registry? Defaults to `false`.||False|
|retention_policy| A `retention_policy` block as documented below.||False|
|trust_policy| A `trust_policy` block as documented below.||False|
|zone_redundancy_enabled| Whether zone redundancy is enabled for this Container Registry? Changing this forces a new resource to be created. Defaults to `false`.||False|
|quarantine_policy_enabled`, `retention_policy`, `trust_policy|||False|
|identity| An `identity` block as defined below.||False|
|encryption| An `encryption` block as documented below.||False|
|anonymous_pull_enabled| Whether allows anonymous (unauthenticated) pull access to this Container Registry? Defaults to `false`. This is only supported on resources with the `Standard` or `Premium` SKU.||False|
|data_endpoint_enabled| Whether to enable dedicated data endpoints for this Container Registry? Defaults to `false`. This is only supported on resources with the `Premium` SKU.||False|
|network_rule_bypass_option| Whether to allow trusted Azure services to access a network restricted Container Registry? Possible values are `None` and `AzureServices`. Defaults to `AzureServices`.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Container Registry.|||
|login_server|The URL that can be used to log into the container registry.|||
|admin_username|The Username associated with the Container Registry Admin account - if the admin account is enabled.|||
|admin_password|The Password associated with the Container Registry Admin account - if the admin account is enabled.|||
|identity|An `identity` block as defined below, which contains the Managed Service Identity information for this Container Registry.|||
