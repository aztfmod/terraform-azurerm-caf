module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# eventgrid_domain

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the EventGrid Domain resource. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
| region |The region_key where the resource will be deployed|String|True|
|identity| An `identity` block as defined below.| Block |False|
|input_schema| Specifies the schema in which incoming events will be published to this domain. Allowed values are `CloudEventSchemaV1_0`, `CustomEventSchema`, or `EventGridSchema`. Defaults to `eventgridschema`. Changing this forces a new resource to be created.||False|
|input_mapping_fields| A `input_mapping_fields` block as defined below.| Block |False|
|input_mapping_default_values| A `input_mapping_default_values` block as defined below.| Block |False|
|public_network_access_enabled| Whether or not public network access is allowed for this server. Defaults to `true`.||False|
|local_auth_enabled| Whether local authentication methods is enabled for the EventGrid Domain. Defaults to `true`.||False|
|auto_create_topic_with_first_subscription| Whether to create the domain topic when the first event subscription at the scope of the domain topic is created. Defaults to `true`.||False|
|auto_delete_topic_with_last_subscription| Whether to delete the domain topic when the last event subscription at the scope of the domain topic is deleted. Defaults to `true`.||False|
|inbound_ip_rule| One or more `inbound_ip_rule` blocks as defined below.| Block |False|
|tags| A mapping of tags to assign to the resource.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|identity|type|Specifies the identity type of Event Grid Domain. Possible values are `SystemAssigned` (where Azure will generate a Principal for you) or `UserAssigned` where you can specify the User Assigned Managed Identity IDs in the `identity_ids` field.|||False|
|identity|identity_ids| Specifies a list of user managed identity ids to be assigned. Required if `type` is `UserAssigned`.|||False|
|input_mapping_fields|id| Specifies the id of the EventGrid Event to associate with the domain. Changing this forces a new resource to be created.|||False|
|input_mapping_fields|topic| Specifies the topic of the EventGrid Event to associate with the domain. Changing this forces a new resource to be created.|||False|
|input_mapping_fields|event_type| Specifies the event type of the EventGrid Event to associate with the domain. Changing this forces a new resource to be created.|||False|
|input_mapping_fields|event_time| Specifies the event time of the EventGrid Event to associate with the domain. Changing this forces a new resource to be created.|||False|
|input_mapping_fields|data_version| Specifies the data version of the EventGrid Event to associate with the domain. Changing this forces a new resource to be created.|||False|
|input_mapping_fields|subject| Specifies the subject of the EventGrid Event to associate with the domain. Changing this forces a new resource to be created.|||False|
|input_mapping_default_values|event_type| Specifies the default event type of the EventGrid Event to associate with the domain. Changing this forces a new resource to be created.|||False|
|input_mapping_default_values|data_version| Specifies the default data version of the EventGrid Event to associate with the domain. Changing this forces a new resource to be created.|||False|
|input_mapping_default_values|subject| Specifies the default subject of the EventGrid Event to associate with the domain. Changing this forces a new resource to be created.|||False|
|inbound_ip_rule|ip_mask| The ip mask (CIDR) to match on.|||True|
|inbound_ip_rule|action| The action to take when the rule is matched. Possible values are `Allow`.|||False|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the EventGrid Domain.|||
|endpoint|The Endpoint associated with the EventGrid Domain.|||
|primary_access_key|The Primary Shared Access Key associated with the EventGrid Domain.|||
|secondary_access_key|The Secondary Shared Access Key associated with the EventGrid Domain.|||
|identity|An `identity` block as defined below, which contains the Managed Service Identity information for this Event Grid Domain.|||
