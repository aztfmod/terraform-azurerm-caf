# Azure Compute Resources

This module is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this directly using the following parameters:

```hcl
module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
  # insert the 7 required variables here
}
```

module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# logic_app_workflow

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the Logic App Workflow. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
| region |The region_key where the resource will be deployed|String|True|
|access_control| A `access_control` block as defined below.| Block |False|
|identitiy| An `identitiy` block as defined below.||False|
|integration_service_environment|The `integration_service_environment` block as defined below.|Block|False|
|logic_app_integration_account|The `logic_app_integration_account` block as defined below.|Block|False|
|state| The state of the Logic App Workflow. Defaults to `true`.||False|
|workflow_parameters| Specifies a map of Key-Value pairs of the Parameter Definitions to use for this Logic App Workflow. The key is the parameter name, and the value is a json encoded string of the parameter definition (see: https://docs.microsoft.com/en-us/azure/logic-apps/logic-apps-workflow-definition-language#parameters).||False|
|workflow_schema| Specifies the Schema to use for this Logic App Workflow. Defaults to `https://schema.management.azure.com/providers/Microsoft.Logic/schemas/2016-06-01/workflowdefinition.json#`. Changing this forces a new resource to be created.||False|
|workflow_version| Specifies the version of the Schema used for this Logic App Workflow. Defaults to `1.0.0.0`. Changing this forces a new resource to be created.||False|
|parameters| A map of Key-Value pairs.||False|
|tags| A mapping of tags to assign to the resource.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|access_control|action| A `action` block as defined below.|||False|
|action|allowed_caller_ip_address_range| A list of the allowed caller IP address ranges.|||True|
|access_control|content| A `content` block as defined below.|||False|
|content|allowed_caller_ip_address_range| A list of the allowed caller IP address ranges.|||True|
|access_control|trigger| A `trigger` block as defined below.|||False|
|trigger|allowed_caller_ip_address_range| A list of the allowed caller IP address ranges.|||True|
|trigger|open_authentication_policy| A `open_authentication_policy` block as defined below.|||False|
|open_authentication_policy|name| The OAuth policy name for the Logic App Workflow.|||True|
|open_authentication_policy|claim| A `claim` block as defined below.|||True|
|claim|name| The name of the OAuth policy claim for the Logic App Workflow.|||True|
|claim|value| The value of the OAuth policy claim for the Logic App Workflow.|||True|
|access_control|workflow_management| A `workflow_management` block as defined below.|||False|
|workflow_management|allowed_caller_ip_address_range| A list of the allowed caller IP address ranges.|||True|
|integration_service_environment| key | Key for  integration_service_environment||| Required if  |
|integration_service_environment| lz_key |Landing Zone Key in wich the integration_service_environment is located|||False|
|integration_service_environment| id | The id of the integration_service_environment |||False|
|logic_app_integration_account| key | Key for  logic_app_integration_account||| Required if  |
|logic_app_integration_account| lz_key |Landing Zone Key in wich the logic_app_integration_account is located|||False|
|logic_app_integration_account| id | The id of the logic_app_integration_account |||False|

## Outputs
| Name | Description |
|------|-------------|
|id|The Logic App Workflow ID.|||
|access_endpoint|The Access Endpoint for the Logic App Workflow.|||
|connector_endpoint_ip_addresses|The list of access endpoint ip addresses of connector.|||
|connector_outbound_ip_addresses|The list of outgoing ip addresses of connector.|||
|identity|An `identity` block as defined below.|||
|workflow_endpoint_ip_addresses|The list of access endpoint ip addresses of workflow.|||
|workflow_outbound_ip_addresses|The list of outgoing ip addresses of workflow.|||

module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# logic_app_integration_account

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name which should be used for this Logic App Integration Account. Changing this forces a new Logic App Integration Account to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
| region |The region_key where the resource will be deployed|String|True|
|sku_name| The sku name of the Logic App Integration Account. Possible Values are `Basic`, `Free` and `Standard`.||True|
|integration_service_environment|The `integration_service_environment` block as defined below.|Block|False|
|tags| A mapping of tags which should be assigned to the Logic App Integration Account.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|integration_service_environment| key | Key for  integration_service_environment||| Required if  |
|integration_service_environment| lz_key |Landing Zone Key in wich the integration_service_environment is located|||False|
|integration_service_environment| id | The id of the integration_service_environment |||False|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Logic App Integration Account.|||

module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# logic_app_trigger_http_request

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the HTTP Request Trigger to be created within the Logic App Workflow. Changing this forces a new resource to be created.||True|
|logic_app_id| Specifies the ID of the Logic App Workflow. Changing this forces a new resource to be created.||True|
|schema| A JSON Blob defining the Schema of the incoming request. This needs to be valid JSON.||True|
|method| Specifies the HTTP Method which the request be using. Possible values include `DELETE`, `GET`, `PATCH`, `POST` or `PUT`.||False|
|relative_path| Specifies the Relative Path used for this Request.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the HTTP Request Trigger within the Logic App Workflow.|||
|callback_url|The URL for the workflow trigger|||

module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# logic_app_trigger_custom

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the HTTP Trigger to be created within the Logic App Workflow. Changing this forces a new resource to be created.||True|
|logic_app_id| Specifies the ID of the Logic App Workflow. Changing this forces a new resource to be created.||True|
|body| Specifies the JSON Blob defining the Body of this Custom Trigger.||True|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Trigger within the Logic App Workflow.|||

module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# logic_app_trigger_recurrence

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the Recurrence Triggers to be created within the Logic App Workflow. Changing this forces a new resource to be created.||True|
|logic_app_id| Specifies the ID of the Logic App Workflow. Changing this forces a new resource to be created.||True|
|frequency| Specifies the Frequency at which this Trigger should be run. Possible values include `Month`, `Week`, `Day`, `Hour`, `Minute` and `Second`.||True|
|interval| Specifies interval used for the Frequency, for example a value of `4` for `interval` and `hour` for `frequency` would run the Trigger every 4 hours.||True|
|start_time| Specifies the start date and time for this trigger in RFC3339 format: `2000-01-02T03:04:05Z`.||False|
|time_zone| Specifies the time zone for this trigger.  Supported time zone options are listed [here](https://support.microsoft.com/en-us/help/973627/microsoft-time-zone-index-values)||False|
|schedule| A `schedule` block as specified below.| Block |False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|schedule|at_these_minutes|Specifies a list of minutes when the trigger should run. Valid values are between 0 and 59.|||False|
|schedule|at_these_hours|Specifies a list of hours when the trigger should run. Valid values are between 0 and 23.|||False|
|schedule|on_these_days|Specifies a list of days when the trigger should run. Valid values include `Monday`, `Tuesday`, `Wednesday`, `Thursday`, `Friday`, `Saturday`, and `Sunday`.|||False|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Recurrence Trigger within the Logic App Workflow.|||
