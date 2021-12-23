module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# application_insights

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the Application Insights component. Changing this forces a||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
| region |The region_key where the resource will be deployed|String|True|
|application_type| Specifies the type of Application Insights to create. Valid values are `ios` for _iOS_, `java` for _Java web_, `MobileCenter` for _App Center_, `Node.JS` for _Node.js_, `other` for _General_, `phone` for _Windows Phone_, `store` for _Windows Store_ and `web` for _ASP.NET_. Please note these values are case sensitive; unmatched values are treated as _ASP.NET_ by Azure. Changing this forces a new resource to be created.||True|
|daily_data_cap_in_gb| Specifies the Application Insights component daily data volume cap in GB.||False|
|daily_data_cap_notifications_disabled| Specifies if a notification email will be send when the daily data volume cap is met.||False|
|retention_in_days| Specifies the retention period in days. Possible values are `30`, `60`, `90`, `120`, `180`, `270`, `365`, `550` or `730`. Defaults to `90`.||False|
|sampling_percentage| Specifies the percentage of the data produced by the monitored application that is sampled for Application Insights telemetry.||False|
|disable_ip_masking| By default the real client ip is masked as `0.0.0.0` in the logs. Use this argument to disable masking and log the real client ip. Defaults to `false`.||False|
|tags| A mapping of tags to assign to the resource.||False|
|workspace_id| Specifies the id of a log analytics workspace resource||False|
|local_authentication_disabled| Disable Non-Azure AD based Auth. Defaults to `false`.||False|
|internet_ingestion_enabled | Should the Application Insights component support ingestion over the Public Internet? Defaults to `true`.||False|
|internet_query_enabled| Should the Application Insights component support querying over the Public Internet? Defaults to `true`.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Application Insights component.|||
|app_id|The App ID associated with this Application Insights component.|||
|instrumentation_key|The Instrumentation Key for this Application Insights component. (Sensitive)|||
|connection_string|The Connection String for this Application Insights component. (Sensitive)|||
