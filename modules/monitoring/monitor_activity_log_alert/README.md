module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# monitor_activity_log_alert

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name of the activity log alert. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|scopes| The Scope at which the Activity Log should be applied, for example a the Resource ID of a Subscription or a Resource (such as a Storage Account).||True|
|criteria| A `criteria` block as defined below.| Block |True|
|action| One or more `action` blocks as defined below.| Block |False|
|enabled| Should this Activity Log Alert be enabled? Defaults to `true`.||False|
|description| The description of this activity log alert.||False|
|tags| A mapping of tags to assign to the resource.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|criteria|category| The category of the operation. Possible values are `Administrative`, `Autoscale`, `Policy`, `Recommendation`, `ResourceHealth`, `Security` and `ServiceHealth`.|||True|
|criteria|operation_name| The Resource Manager Role-Based Access Control operation name. Supported operation should be of the form: `<resourceProvider>/<resourceType>/<operation>`.|||False|
|criteria|resource_provider| The name of the resource provider monitored by the activity log alert.|||False|
|criteria|resource_type| The resource type monitored by the activity log alert.|||False|
|criteria|resource_group| The name of resource group monitored by the activity log alert.|||False|
|criteria|resource_id| The specific resource monitored by the activity log alert. It should be within one of the `scopes`.|||False|
|criteria|caller| The email address or Azure Active Directory identifier of the user who performed the operation.|||False|
|criteria|level| The severity level of the event. Possible values are `Verbose`, `Informational`, `Warning`, `Error`, and `Critical`.|||False|
|criteria|status| The status of the event. For example, `Started`, `Failed`, or `Succeeded`.|||False|
|criteria|sub_status| The sub status of the event.|||False|
|criteria|recommendation_type| The recommendation type of the event. It is only allowed when `category` is `Recommendation`.|||False|
|criteria|recommendation_category| The recommendation category of the event. Possible values are `Cost`, `Reliability`, `OperationalExcellence` and `Performance`. It is only allowed when `category` is `Recommendation`.|||False|
|criteria|recommendation_impact| The recommendation impact of the event. Possible values are `High`, `Medium` and `Low`. It is only allowed when `category` is `Recommendation`.|||False|
|criteria|service_health| A block to define fine grain service health settings.|||False|
|service_health|events||||False|
|service_health|locations||||False|
|service_health|services||||False|
|action|action_group_id| The ID of the Action Group can be sourced from [the `azurerm_monitor_action_group` resource](./monitor_action_group.html).|||True|
|action|webhook_properties| The map of custom string properties to include with the post operation. These data are appended to the webhook payload.|||False|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the activity log alert.|||
