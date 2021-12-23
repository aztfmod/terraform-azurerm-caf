# Azure consumption_budget Resources

This module is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this directly using the following parameters:

```hcl
module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.4.2"
  # insert the 7 required variables here
}
```

## Example scenarios

The following examples are available:

| Scenario                                                     | Description                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [100-consumption-budget-rg](./100-consumption-budget-rg)     | Simple example for consumption budget deployed at resource group scope. |
| [101-consumption-budget-subscription](./101-consumption-budget-subscription) | Simple example for consumption budget deployed at subscription scope. |
| [102-consumption-budget-rg-alerts](./102-consumption-budget-rg-alerts) | Simple example for consumption budget deployed at resource group scope, integrated with action groups. |
| [103-consumption-budget-subscription-alerts](./103-consumption-budget-subscription-alerts) | Simple example for consumption budget deployed at subscription scope, integrated with action groups. |
| [104-consumption-budget-subscription-vm](./104-consumption-budget-subscription-vm) | Consumption budget deployed at subscription scope, integrated with Azure windows virtual machine. |
| [105-consumption-budget-subscription-aks](./105-consumption-budget-subscription-vm) | Consumption budget deployed at subscription scope, integrated with Azure Kubernetes Service single cluster |

## Run this example

You can run this example directly using Terraform or via rover:

### With Terraform

```bash
#Login to your Azure subscription
az login

#Run the example
cd /tf/caf/examples

terraform init

terraform [plan | apply | destroy] \
  -var-file ./consumption_budget/102-consumption-budget-rg-alerts/configuration.tfvars
```

### With rover

To test this deployment in the example landingzone, make sure the launchpad has been deployed first, then run the following command:

```bash
rover \
  -lz /tf/caf/examples \
  -var-folder  /tf/caf/examples/consumption_budget/102-consumption-budget-rg-alerts/ \
  -level level1 \
  -a [plan | apply | destroy]
```

module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# consumption_budget_resource_group

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name which should be used for this Resource Group Consumption Budget. Changing this forces a new Resource Group Consumption Budget to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|amount| The total amount of cost to track with the budget.||True|
|time_grain| The time covered by a budget. Tracking of the amount will be reset based on the time grain. Must be one of `Monthly`, `Quarterly`, `Annually`, `BillingMonth`, `BillingQuarter`, or `BillingYear`. Defaults to `Monthly`.||True|
|time_period| A `time_period` block as defined below.| Block |True|
|notification| One or more `notification` blocks as defined below.| Block |True|
|filter| A `filter` block as defined below.| Block |False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| id | The id of the resource_group |||True|
|time_period|start_date| The start date for the budget. The start date must be first of the month and should be less than the end date. Budget start date must be on or after June 1, 2017. Future start date should not be more than twelve months. Past start date should be selected within the timegrain period. Changing this forces a new Resource Group Consumption Budget to be created.|||True|
|time_period|end_date| The end date for the budget. If not set this will be 10 years after the start date.|||False|
|notification|operator| The comparison operator for the notification. Must be one of `EqualTo`, `GreaterThan`, or `GreaterThanOrEqualTo`.|||True|
|notification|threshold| Threshold value associated with a notification. Notification is sent when the cost exceeded the threshold. It is always percent and has to be between 0 and 1000.|||True|
|notification|threshold_type| The type of threshold for the notification. This determines whether the notification is triggered by forecasted costs or actual costs. The allowed values are `Actual` and `Forecasted`. Default is `Actual`.|||False|
|notification|contact_emails| Specifies a list of email addresses to send the budget notification to when the threshold is exceeded.|||False|
|notification|contact_groups| Specifies a list of Action Group IDs to send the budget notification to when the threshold is exceeded.|||False|
|notification|contact_roles| Specifies a list of contact roles to send the budget notification to when the threshold is exceeded.|||False|
|notification|enabled| Should the notification be enabled?|||False|
|filter|dimension| One or more `dimension` blocks as defined below to filter the budget on.|||False|
|dimension|name| The name of the column to use for the filter. The allowed values are `ChargeType`, `Frequency`, `InvoiceId`, `Meter`, `MeterCategory`, `MeterSubCategory`, `PartNumber`, `PricingModel`, `Product`, `ProductOrderId`, `ProductOrderName`, `PublisherType`, `ReservationId`, `ReservationName`, `ResourceGroupName`, `ResourceGuid`, `ResourceId`, `ResourceLocation`, `ResourceType`, `ServiceFamily`, `ServiceName`, `UnitOfMeasure`.|||True|
|dimension|operator| The operator to use for comparison. The allowed values are `In`.|||False|
|dimension|values| Specifies a list of values for the column.|||True|
|filter|tag| One or more `tag` blocks as defined below to filter the budget on.|||False|
|tag|name| The name of the tag to use for the filter.|||True|
|tag|operator| The operator to use for comparison. The allowed values are `In`.|||False|
|tag|values| Specifies a list of values for the tag.|||True|
|filter|not| A `not` block as defined below to filter the budget on.|||False|
|not|dimension| One `dimension` block as defined below to filter the budget on. Conflicts with `tag`.|||False|
|dimension|name| The name of the column to use for the filter. The allowed values are `ChargeType`, `Frequency`, `InvoiceId`, `Meter`, `MeterCategory`, `MeterSubCategory`, `PartNumber`, `PricingModel`, `Product`, `ProductOrderId`, `ProductOrderName`, `PublisherType`, `ReservationId`, `ReservationName`, `ResourceGroupName`, `ResourceGuid`, `ResourceId`, `ResourceLocation`, `ResourceType`, `ServiceFamily`, `ServiceName`, `UnitOfMeasure`.|||True|
|dimension|operator| The operator to use for comparison. The allowed values are `In`.|||False|
|dimension|values| Specifies a list of values for the column.|||True|
|not|tag| One `tag` block as defined below to filter the budget on. Conflicts with `dimension`.|||False|
|tag|name| The name of the tag to use for the filter.|||True|
|tag|operator| The operator to use for comparison. The allowed values are `In`.|||False|
|tag|values| Specifies a list of values for the tag.|||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Resource Group Consumption Budget.|||
|etag|The ETag of the Resource Group Consumption Budget|||


module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# consumption_budget_subscription

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name which should be used for this Subscription Consumption Budget. Changing this forces a new resource to be created.||True|
|subscription|The `subscription` block as defined below.|Block|True|
|amount| The total amount of cost to track with the budget.||True|
|time_grain| The time covered by a budget. Tracking of the amount will be reset based on the time grain. Must be one of `Monthly`, `Quarterly`, `Annually`, `BillingMonth`, `BillingQuarter`, or `BillingYear`. Defaults to `Monthly`.||True|
|time_period| A `time_period` block as defined below.| Block |True|
|notification| One or more `notification` blocks as defined below.| Block |True|
|filter| A `filter` block as defined below.| Block |False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|subscription| key | Key for  subscription||| Required if  |
|subscription| lz_key |Landing Zone Key in wich the subscription is located|||True|
|subscription| id | The id of the subscription |||True|
|time_period|start_date| The start date for the budget. The start date must be first of the month and should be less than the end date. Budget start date must be on or after June 1, 2017. Future start date should not be more than twelve months. Past start date should be selected within the timegrain period. Changing this forces a new Subscription Consumption Budget to be created.|||True|
|time_period|end_date| The end date for the budget. If not set this will be 10 years after the start date.|||False|
|notification|operator| The comparison operator for the notification. Must be one of `EqualTo`, `GreaterThan`, or `GreaterThanOrEqualTo`.|||True|
|notification|threshold| Threshold value associated with a notification. Notification is sent when the cost exceeded the threshold. It is always percent and has to be between 0 and 1000.|||True|
|notification|threshold_type| The type of threshold for the notification. This determines whether the notification is triggered by forecasted costs or actual costs. The allowed values are `Actual` and `Forecasted`. Default is `Actual`. Changing this forces a new resource to be created.|||False|
|notification|contact_emails| Specifies a list of email addresses to send the budget notification to when the threshold is exceeded.|||False|
|notification|contact_groups| Specifies a list of Action Group IDs to send the budget notification to when the threshold is exceeded.|||False|
|notification|contact_roles| Specifies a list of contact roles to send the budget notification to when the threshold is exceeded.|||False|
|notification|enabled| Should the notification be enabled?|||False|
|filter|dimension| One or more `dimension` blocks as defined below to filter the budget on.|||False|
|dimension|name| The name of the column to use for the filter. The allowed values are `ChargeType`, `Frequency`, `InvoiceId`, `Meter`, `MeterCategory`, `MeterSubCategory`, `PartNumber`, `PricingModel`, `Product`, `ProductOrderId`, `ProductOrderName`, `PublisherType`, `ReservationId`, `ReservationName`, `ResourceGroupName`, `ResourceGuid`, `ResourceId`, `ResourceLocation`, `ResourceType`, `ServiceFamily`, `ServiceName`, `UnitOfMeasure`.|||True|
|dimension|operator| The operator to use for comparison. The allowed values are `In`.|||False|
|dimension|values| Specifies a list of values for the column.|||True|
|filter|tag| One or more `tag` blocks as defined below to filter the budget on.|||False|
|tag|name| The name of the tag to use for the filter.|||True|
|tag|operator| The operator to use for comparison. The allowed values are `In`.|||False|
|tag|values| Specifies a list of values for the tag.|||True|
|filter|not| A `not` block as defined below to filter the budget on.|||False|
|not|dimension| One `dimension` block as defined below to filter the budget on. Conflicts with `tag`.|||False|
|dimension|name| The name of the column to use for the filter. The allowed values are `ChargeType`, `Frequency`, `InvoiceId`, `Meter`, `MeterCategory`, `MeterSubCategory`, `PartNumber`, `PricingModel`, `Product`, `ProductOrderId`, `ProductOrderName`, `PublisherType`, `ReservationId`, `ReservationName`, `ResourceGroupName`, `ResourceGuid`, `ResourceId`, `ResourceLocation`, `ResourceType`, `ServiceFamily`, `ServiceName`, `UnitOfMeasure`.|||True|
|dimension|operator| The operator to use for comparison. The allowed values are `In`.|||False|
|dimension|values| Specifies a list of values for the column.|||True|
|not|tag| One `tag` block as defined below to filter the budget on. Conflicts with `dimension`.|||False|
|tag|name| The name of the tag to use for the filter.|||True|
|tag|operator| The operator to use for comparison. The allowed values are `In`.|||False|
|tag|values| Specifies a list of values for the tag.|||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Subscription Consumption Budget.|||
|etag|The ETag of the Subscription Consumption Budget.|||
