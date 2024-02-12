module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# eventgrid_system_topic_event_subscription

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the EventGrid Event Grid Event Subscription resource. Changing this forces a new resource to be created.||True|
|system_topic| Specifies the system topic for where the EventGrid System Topic Event Subscription should be created. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|webhook_endpoint|The `webhook_endpoint` block as defined below.|Block|True|


## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|webhook_endpoint|url| Specifies the url of the webhook where the Event Subscription will receive events.|||True|
|webhook_endpoint|base_url| The base url of the webhook where the Event Subscription will receive events.|||False|
|webhook_endpoint|max_events_per_batch| Maximum number of events per batch.|||False|
|webhook_endpoint|preferred_batch_size_in_kilobytes| Preferred batch size in Kilobytes.|||False|
|webhook_endpoint|active_directory_tenant_id| The Azure Active Directory Tenant ID to get the access token that will be included as the bearer token in delivery requests.|||False|
|webhook_endpoint|active_directory_app_id_or_uri| The Azure Active Directory Application ID or URI to get the access token that will be included as the bearer token in delivery requests.|||False|


## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the EventGrid Event Subscription.|||
