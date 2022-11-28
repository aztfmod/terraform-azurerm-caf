module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# monitor_metric_alert

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name of the Metric Alert. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|scopes| A set of strings of resource IDs at which the metric criteria should be applied.||True|
|criteria| One or more (static) `criteria` blocks as defined below.| Block |False|
|dynamic_criteria| A `dynamic_criteria` block as defined below.| Block |False|
|application_insights_web_test_location_availability_criteria| A `application_insights_web_test_location_availability_criteria` block as defined below.| Block |False|
|action| One or more `action` blocks as defined below.| Block |False|
|enabled| Should this Metric Alert be enabled? Defaults to `true`.||False|
|auto_mitigate| Should the alerts in this Metric Alert be auto resolved? Defaults to `true`.||False|
|description| The description of this Metric Alert.||False|
|frequency| The evaluation frequency of this Metric Alert, represented in ISO 8601 duration format. Possible values are `PT1M`, `PT5M`, `PT15M`, `PT30M` and `PT1H`. Defaults to `PT1M`.||False|
|severity| The severity of this Metric Alert. Possible values are `0`, `1`, `2`, `3` and `4`. Defaults to `3`.||False|
|target_resource_type| The resource type (e.g. `Microsoft.Compute/virtualMachines`) of the target resource.||False|
|target_resource_location| The location of the target resource.||False|
|window_size| The period of time that is used to monitor alert activity, represented in ISO 8601 duration format. This value must be greater than `frequency`. Possible values are `PT1M`, `PT5M`, `PT15M`, `PT30M`, `PT1H`, `PT6H`, `PT12H` and `P1D`. Defaults to `PT5M`.||False|
|tags| A mapping of tags to assign to the resource.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|criteria|metric_namespace| One of the metric namespaces to be monitored.|||True|
|criteria|metric_name| One of the metric names to be monitored.|||True|
|criteria|aggregation| The statistic that runs over the metric values. Possible values are `Average`, `Count`, `Minimum`, `Maximum` and `Total`.|||True|
|criteria|operator| The criteria operator. Possible values are `Equals`, `NotEquals`, `GreaterThan`, `GreaterThanOrEqual`, `LessThan` and `LessThanOrEqual`.|||True|
|criteria|threshold| The criteria threshold value that activates the alert.|||True|
|criteria|dimension| One or more `dimension` blocks as defined below.|||False|
|dimension|name| One of the dimension names.|||True|
|dimension|operator| The dimension operator. Possible values are `Include`, `Exclude` and `StartsWith`.|||True|
|dimension|values| The list of dimension values.|||True|
|criteria|skip_metric_validation| Skip the metric validation to allow creating an alert rule on a custom metric that isn't yet emitted? Defaults to `false`.|||False|
|dynamic_criteria|metric_namespace| One of the metric namespaces to be monitored.|||True|
|dynamic_criteria|metric_name| One of the metric names to be monitored.|||True|
|dynamic_criteria|aggregation| The statistic that runs over the metric values. Possible values are `Average`, `Count`, `Minimum`, `Maximum` and `Total`.|||True|
|dynamic_criteria|operator| The criteria operator. Possible values are `LessThan`, `GreaterThan` and `GreaterOrLessThan`.|||True|
|dynamic_criteria|alert_sensitivity| The extent of deviation required to trigger an alert. Possible values are `Low`, `Medium` and `High`.|||True|
|dynamic_criteria|dimension| One or more `dimension` blocks as defined below.|||False|
|dimension|name| One of the dimension names.|||True|
|dimension|operator| The dimension operator. Possible values are `Include`, `Exclude` and `StartsWith`.|||True|
|dimension|values| The list of dimension values.|||True|
|dynamic_criteria|evaluation_total_count| The number of aggregated lookback points. The lookback time window is calculated based on the aggregation granularity (`window_size`) and the selected number of aggregated points.|||False|
|dynamic_criteria|evaluation_failure_count| The number of violations to trigger an alert. Should be smaller or equal to `evaluation_total_count`.|||False|
|dynamic_criteria|ignore_data_before| The [ISO8601](https://en.wikipedia.org/wiki/ISO_8601) date from which to start learning the metric historical data and calculate the dynamic thresholds.|||False|
|dynamic_criteria|skip_metric_validation| Skip the metric validation to allow creating an alert rule on a custom metric that isn't yet emitted? Defaults to `false`.|||False|
|application_insights_web_test_location_availability_criteria|web_test_id| The ID of the Application Insights Web Test.|||True|
|application_insights_web_test_location_availability_criteria|component_id| The ID of the Application Insights Resource.|||True|
|application_insights_web_test_location_availability_criteria|failed_location_count| The number of failed locations.|||True|
|action|action_group_id| The ID of the Action Group can be sourced from [the `azurerm_monitor_action_group` resource](./monitor_action_group.html)|||True|
|action|webhook_properties| The map of custom string properties to include with the post operation. These data are appended to the webhook payload.|||False|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the metric alert.|||
