# data_factory_trigger_schedule

This module is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this directly using the following parameters:

```hcl
module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "~>5.5.0"

  # Add object as described below
}
```

CAF Terraform module is iterative by default, you can instantiate as many objects as needed, using the following structure:

```hcl
resource_to_be_created = {
  object1 = {
    #configuration details as below
  }
  object2 = {
    #configuration details as below
  }
}
```


## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the Data Factory Schedule Trigger. Changing this forces a new resource to be created. Must be globally unique. See the [Microsoft documentation](https://docs.microsoft.com/en-us/azure/data-factory/naming-rules) for all restrictions.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|data_factory|The `data_factory` block as defined below.|Block|True|
|pipeline_name| The Data Factory Pipeline name that the trigger will act on.||True|
|description| The Schedule Trigger's description.||False|
|schedule| A `schedule` block as defined below, which further specifies the recurrence schedule for the trigger. A schedule is capable of limiting or increasing the number of trigger executions specified by the `frequency` and `interval` properties.| Block |False|
|start_time| The time the Schedule Trigger will start. This defaults to the current time. The time will be represented in UTC.||False|
|end_time| The time the Schedule Trigger should end. The time will be represented in UTC.||False|
|interval| The interval for how often the trigger occurs. This defaults to 1.||False|
|frequency| The trigger frequency. Valid values include `Minute`, `Hour`, `Day`, `Week`, `Month`. Defaults to `Minute`.||False|
|activated| Specifies if the Data Factory Schedule Trigger is activated. Defaults to `true`.||False|
|pipeline_parameters| The pipeline parameters that the trigger will act upon.||False|
|annotations| List of tags that can be used for describing the Data Factory Schedule Trigger.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|data_factory| key | Key for  data_factory||| Required if  |
|data_factory| lz_key |Landing Zone Key in wich the data_factory is located|||True|
|data_factory| name | The name of the data_factory |||True|
|schedule|days_of_month| Day(s) of the month on which the trigger is scheduled. This value can be specified with a monthly frequency only.|||False|
|schedule|days_of_week| Days of the week on which the trigger is scheduled. This value can be specified only with a weekly frequency.|||False|
|schedule|hours| Hours of the day on which the trigger is scheduled.|||False|
|schedule|minutes| Minutes of the hour on which the trigger is scheduled.|||False|
|schedule|monthly| A `monthly` block as documented below, which specifies the days of the month on which the trigger is scheduled. The value can be specified only with a monthly frequency.|||False|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Data Factory Schedule Trigger.|||
