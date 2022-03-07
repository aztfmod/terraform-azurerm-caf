module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# synapse_workspace_security_alert_policy

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|synapse_workspace|The `synapse_workspace` block as defined below.|Block|True|
|policy_state| Specifies the state of the policy, whether it is enabled or disabled or a policy has not been applied yet on the specific workspace. Allowed values are: `Disabled`, `Enabled`.||True|
|disabled_alerts| Specifies an array of alerts that are disabled. Allowed values are: `Sql_Injection`, `Sql_Injection_Vulnerability`, `Access_Anomaly`, `Data_Exfiltration`, `Unsafe_Action`.||False|
|email_account_admins_enabled| Boolean flag which specifies if the alert is sent to the account administrators or not. Defaults to `false`.||False|
|email_addresses| Specifies an array of e-mail addresses to which the alert is sent.||False|
|retention_days| Specifies the number of days to keep in the Threat Detection audit logs. Defaults to `0`.||False|
|storage_account_access_key| Specifies the identifier key of the Threat Detection audit storage account.||False|
|storage_endpoint| Specifies the blob storage endpoint (e.g. https://MyAccount.blob.core.windows.net). This blob storage will hold all Threat Detection audit logs.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|synapse_workspace| key | Key for  synapse_workspace||| Required if  |
|synapse_workspace| lz_key |Landing Zone Key in wich the synapse_workspace is located|||True|
|synapse_workspace| id | The id of the synapse_workspace |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Synapse Workspace Security Alert Policy.|||
