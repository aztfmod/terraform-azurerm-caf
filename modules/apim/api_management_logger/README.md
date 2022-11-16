module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# api_management_logger

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name of this Logger, which must be unique within the API Management Service. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|api_management|The `api_management` block as defined below.|Block|True|
|application_insights| An `application_insights` block as documented below.| Block |False|
|buffered| Specifies whether records should be buffered in the Logger prior to publishing. Defaults to `true`.||False|
|description| A description of this Logger.||False|
|eventhub| An `eventhub` block as documented below.| Block |False|
|resource_id| The target resource id which will be linked in the API-Management portal page.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|api_management| key | Key for  api_management||| Required if  |
|api_management| lz_key |Landing Zone Key in wich the api_management is located|||True|
|api_management| name | The name of the api_management |||True|
|application_insights|instrumentation_key| The instrumentation key used to push data to Application Insights.|||True|
|eventhub|name| The name of an EventHub.|||True|
|eventhub|connection_string| The connection string of an EventHub Namespace.|||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the API Management Logger.|||
