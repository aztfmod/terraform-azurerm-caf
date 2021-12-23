module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# eventhub

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the EventHub resource. Changing this forces a new resource to be created.||True|
|namespace_name| Specifies the name of the EventHub Namespace. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|partition_count| Specifies the current number of shards on the Event Hub. Changing this forces a new resource to be created.||True|
|message_retention| Specifies the number of days to retain the events for this Event Hub.||True|
|capture_description| A `capture_description` block as defined below.| Block |False|
|status| Specifies the status of the Event Hub resource. Possible values are `Active`, `Disabled` and `SendDisabled`. Defaults to `Active`.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|capture_description|enabled| Specifies if the Capture Description is Enabled.|||True|
|capture_description|encoding| Specifies the Encoding used for the Capture Description. Possible values are `Avro` and `AvroDeflate`.|||True|
|capture_description|interval_in_seconds| Specifies the time interval in seconds at which the capture will happen. Values can be between `60` and `900` seconds. Defaults to `300` seconds.|||False|
|capture_description|size_limit_in_bytes| Specifies the amount of data built up in your EventHub before a Capture Operation occurs. Value should be between `10485760` and `524288000`  bytes. Defaults to `314572800` bytes.|||False|
|capture_description|skip_empty_archives| Specifies if empty files should not be emitted if no events occur during the Capture time window.  Defaults to `false`.|||False|
|capture_description|destination||||False|
|destination|name| The Name of the Destination where the capture should take place. At this time the only supported value is `EventHubArchive.AzureBlockBlob`.|||True|
|destination|archive_name_format|The Blob naming convention for archiving. e.g. `{Namespace}/{EventHub}/{PartitionId}/{Year}/{Month}/{Day}/{Hour}/{Minute}/{Second}`. Here all the parameters (Namespace,EventHub .. etc) are mandatory irrespective of order|||False|
|destination|blob_container_name| The name of the Container within the Blob Storage Account where messages should be archived.|||True|
|destination|storage_account_id| The ID of the Blob Storage Account where messages should be archived.|||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the EventHub.|||
|partition_ids|The identifiers for partitions created for Event Hubs.|||

module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# eventhub_namespace

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the EventHub Namespace resource. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
| region |The region_key where the resource will be deployed|String|True|
|sku| Defines which tier to use. Valid options are `Basic`, `Standard`, and `Premium`. Please not that setting this field to `Premium` will force the creation of a new resource and also requires setting `zone_redundant` to true.||True|
|capacity| Specifies the Capacity / Throughput Units for a `Standard` SKU namespace. Default capacity has a maximum of `2`, but can be increased in blocks of 2 on a committed purchase basis.||False|
|auto_inflate_enabled| Is Auto Inflate enabled for the EventHub Namespace?||False|
|dedicated_cluster_id| Specifies the ID of the EventHub Dedicated Cluster where this Namespace should created. Changing this forces a new resource to be created.||False|
|identity| An `identity` block as defined below. | Block |False|
|maximum_throughput_units| Specifies the maximum number of throughput units when Auto Inflate is Enabled. Valid values range from `1` - `20`.||False|
|zone_redundant| Specifies if the EventHub Namespace should be Zone Redundant (created across Availability Zones). Changing this forces a new resource to be created. Defaults to `false`.||False|
|tags| A mapping of tags to assign to the resource.||False|
|network_rulesets| A `network_rulesets` block as defined below.| Block |False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|identity|type| The Type of Identity which should be used for this EventHub Namespace. At this time the only possible value is `SystemAssigned`.|||True|
|network_rulesets|default_action| The default action to take when a rule is not matched. Possible values are `Allow` and `Deny`. Defaults to `Deny`.|||True|
|network_rulesets|trusted_service_access_enabled| Whether Trusted Microsoft Services are allowed to bypass firewall.|||False|
|network_rulesets|virtual_network_rule| One or more `virtual_network_rule` blocks as defined below.|||False|
|virtual_network_rule|subnet_id| The id of the subnet to match on.|||True|
|virtual_network_rule|ignore_missing_virtual_network_service_endpoint| Are missing virtual network service endpoints ignored? Defaults to `false`.|||False|
|network_rulesets|ip_rule| One or more `ip_rule` blocks as defined below.|||False|
|ip_rule|ip_mask| The ip mask to match on.|||True|
|ip_rule|action| The action to take when the rule is matched. Possible values are `Allow`.|||False|

## Outputs
| Name | Description |
|------|-------------|
|id|The EventHub Namespace ID.|||
|identity|An `identity` block as documented below.|||
|default_primary_connection_string|The primary connection string for the authorization|||
|default_primary_connection_string_alias|The alias of the primary connection string for the authorization|||
|default_primary_key|The primary access key for the authorization rule `RootManageSharedAccessKey`.|||
|default_secondary_connection_string|The secondary connection string for the|||
|default_secondary_connection_string_alias|The alias of the secondary connection string for the|||
|default_secondary_key|The secondary access key for the authorization rule `RootManageSharedAccessKey`.|||

module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# eventhub_namespace_authorization_rule

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the Authorization Rule. Changing this forces a new resource to be created.||True|
|namespace_name| Specifies the name of the EventHub Namespace. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|listen| Grants listen access to this this Authorization Rule. Defaults to `false`.||False|
|send| Grants send access to this this Authorization Rule. Defaults to `false`.||False|
|manage| Grants manage access to this this Authorization Rule. When this property is `true` - both `listen` and `send` must be too. Defaults to `false`.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The EventHub Namespace Authorization Rule ID.|||
|primary_connection_string_alias|The alias of the Primary Connection String for the Authorization Rule, which is generated when disaster recovery is enabled.|||
|secondary_connection_string_alias|The alias of the Secondary Connection String for the Authorization Rule, which is generated when disaster recovery is enabled.|||
|primary_connection_string|The Primary Connection String for the Authorization Rule.|||
|primary_key|The Primary Key for the Authorization Rule.|||
|secondary_connection_string|The Secondary Connection String for the Authorization Rule.|||
|secondary_key|The Secondary Key for the Authorization Rule.|||


module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# eventhub_consumer_group

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the EventHub Consumer Group resource. Changing this forces a new resource to be created.||True|
|namespace_name| Specifies the name of the grandparent EventHub Namespace. Changing this forces a new resource to be created.||True|
|eventhub|The `eventhub` block as defined below.|Block|True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|user_metadata| Specifies the user metadata.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|eventhub| key | Key for  eventhub||| Required if  |
|eventhub| lz_key |Landing Zone Key in wich the eventhub is located|||True|
|eventhub| name | The name of the eventhub |||True|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the EventHub Consumer Group.|||
