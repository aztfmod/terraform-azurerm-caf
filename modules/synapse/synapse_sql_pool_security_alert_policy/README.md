module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# synapse_sql_pool_security_alert_policy

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|sql_pool_id| Specifies the ID of the Synapse SQL Pool. Changing this forces a new resource to be created.||True|
|policy_state| Specifies the state of the policy, whether it is enabled or disabled or a policy has not been applied yet on the specific SQL pool. Allowed values are: `Disabled`, `Enabled`.||True|
|disabled_alerts| Specifies an array of alerts that are disabled. Allowed values are: `Sql_Injection`, `Sql_Injection_Vulnerability`, `Access_Anomaly`, `Data_Exfiltration`, `Unsafe_Action`.||False|
|email_account_admins_enabled| Boolean flag which specifies if the alert is sent to the account administrators or not. Defaults to `false`.||False|
|email_addresses| Specifies an array of e-mail addresses to which the alert is sent.||False|
|retention_days| Specifies the number of days to keep in the Threat Detection audit logs. Defaults to `0`.||False|
|storage_account_access_key| Specifies the identifier key of the Threat Detection audit storage account.||False|
|storage_endpoint| Specifies the blob storage endpoint (e.g. https://MyAccount.blob.core.windows.net). This blob storage will hold all Threat Detection audit logs.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Synapse SQL Pool Security Alert Policy.|||
