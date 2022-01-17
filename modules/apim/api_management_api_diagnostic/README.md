module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# api_management_api_diagnostic

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|api_management_logger|The `api_management_logger` block as defined below.|Block|True|
|api_management|The `api_management` block as defined below.|Block|True|
|api_name| The name of the API on which to configure the Diagnostics Logs. Changing this forces a new API Management Service API Diagnostics Logs to be created.||True|
|identifier| Identifier of the Diagnostics Logs. Possible values are `applicationinsights` and `azuremonitor`. Changing this forces a new API Management Service API Diagnostics Logs to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|always_log_errors| Always log errors. Send telemetry if there is an erroneous condition, regardless of sampling settings.||False|
|backend_request| A `backend_request` block as defined below.| Block |False|
|backend_response| A `backend_response` block as defined below.| Block |False|
|frontend_request| A `frontend_request` block as defined below.| Block |False|
|frontend_response| A `frontend_response` block as defined below.| Block |False|
|http_correlation_protocol| The HTTP Correlation Protocol to use. Possible values are `None`, `Legacy` or `W3C`.||False|
|log_client_ip| Log client IP address.||False|
|sampling_percentage| Sampling (%). For high traffic APIs, please read this [documentation](https://docs.microsoft.com/azure/api-management/api-management-howto-app-insights#performance-implications-and-log-sampling) to understand performance implications and log sampling. Valid values are between `0.0` and `100.0`.||False|
|verbosity| Logging verbosity. Possible values are `verbose`, `information` or `error`.||False|
|operation_name_format| The format of the Operation Name for Application Insights telemetries. Possible values are `Name`, and `Url`. Defaults to `Name`.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|api_management_logger| key | Key for  api_management_logger||| Required if  |
|api_management_logger| lz_key |Landing Zone Key in wich the api_management_logger is located|||True|
|api_management_logger| id | The id of the api_management_logger |||True|
|api_management| key | Key for  api_management||| Required if  |
|api_management| lz_key |Landing Zone Key in wich the api_management is located|||True|
|api_management| name | The name of the api_management |||True|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|backend_request|body_bytes| Number of payload bytes to log (up to 8192).|||False|
|backend_request|headers_to_log| Specifies a list of headers to log.|||False|
|backend_request|data_masking| A `data_masking` block as defined below.|||False|
|data_masking|query_params| A `query_params` block as defined below.|||False|
|query_params|mode| The data masking mode. Possible values are `Mask` and `Hide` for `query_params`. The only possible value is `Mask` for `headers`.|||True|
|query_params|value| The name of the header or the query parameter to mask.|||True|
|data_masking|headers| A `headers` block as defined below.|||False|
|headers|mode| The data masking mode. Possible values are `Mask` and `Hide` for `query_params`. The only possible value is `Mask` for `headers`.|||True|
|headers|value| The name of the header or the query parameter to mask.|||True|
|backend_response|body_bytes| Number of payload bytes to log (up to 8192).|||False|
|backend_response|headers_to_log| Specifies a list of headers to log.|||False|
|backend_response|data_masking| A `data_masking` block as defined below.|||False|
|data_masking|query_params| A `query_params` block as defined below.|||False|
|query_params|mode| The data masking mode. Possible values are `Mask` and `Hide` for `query_params`. The only possible value is `Mask` for `headers`.|||True|
|query_params|value| The name of the header or the query parameter to mask.|||True|
|data_masking|headers| A `headers` block as defined below.|||False|
|headers|mode| The data masking mode. Possible values are `Mask` and `Hide` for `query_params`. The only possible value is `Mask` for `headers`.|||True|
|headers|value| The name of the header or the query parameter to mask.|||True|
|frontend_request|body_bytes| Number of payload bytes to log (up to 8192).|||False|
|frontend_request|headers_to_log| Specifies a list of headers to log.|||False|
|frontend_request|data_masking| A `data_masking` block as defined below.|||False|
|data_masking|query_params| A `query_params` block as defined below.|||False|
|query_params|mode| The data masking mode. Possible values are `Mask` and `Hide` for `query_params`. The only possible value is `Mask` for `headers`.|||True|
|query_params|value| The name of the header or the query parameter to mask.|||True|
|data_masking|headers| A `headers` block as defined below.|||False|
|headers|mode| The data masking mode. Possible values are `Mask` and `Hide` for `query_params`. The only possible value is `Mask` for `headers`.|||True|
|headers|value| The name of the header or the query parameter to mask.|||True|
|frontend_response|body_bytes| Number of payload bytes to log (up to 8192).|||False|
|frontend_response|headers_to_log| Specifies a list of headers to log.|||False|
|frontend_response|data_masking| A `data_masking` block as defined below.|||False|
|data_masking|query_params| A `query_params` block as defined below.|||False|
|query_params|mode| The data masking mode. Possible values are `Mask` and `Hide` for `query_params`. The only possible value is `Mask` for `headers`.|||True|
|query_params|value| The name of the header or the query parameter to mask.|||True|
|data_masking|headers| A `headers` block as defined below.|||False|
|headers|mode| The data masking mode. Possible values are `Mask` and `Hide` for `query_params`. The only possible value is `Mask` for `headers`.|||True|
|headers|value| The name of the header or the query parameter to mask.|||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the API Management Service API Diagnostics Logs.|||
