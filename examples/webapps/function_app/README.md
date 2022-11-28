# Azure Functions

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

# function_app

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the Function App. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
| region |The region_key where the resource will be deployed|String|True|
|app_service_plan|The `app_service_plan` block as defined below.|Block|True|
|app_settings| A map of key-value pairs for [App Settings](https://docs.microsoft.com/en-us/azure/azure-functions/functions-app-settings) and custom values.||False|
|auth_settings| A `auth_settings` block as defined below.| Block |False|
|connection_string| An `connection_string` block as defined below.||False|
|client_affinity_enabled| Should the Function App send session affinity cookies, which route client requests in the same session to the same instance?||False|
|client_cert_mode| The mode of the Function App's client certificates requirement for incoming requests. Possible values are `Required` and `Optional`.||False|
|daily_memory_time_quota| The amount of memory in gigabyte-seconds that your application is allowed to consume per day. Setting this value only affects function apps under the consumption plan. Defaults to `0`.||False|
|enabled| Is the Function App enabled?||False|
|enable_builtin_logging| Should the built-in logging of this Function App be enabled? Defaults to `true`.||False|
|https_only| Can the Function App only be accessed via HTTPS? Defaults to `false`.||False|
|identity| An `identity` block as defined below.| Block |False|
|key_vault_reference_identity_id| The User Assigned Identity Id used for looking up KeyVault secrets. The identity must be assigned to the application. See [Access vaults with a user-assigned identity](https://docs.microsoft.com/en-us/azure/app-service/app-service-key-vault-references#access-vaults-with-a-user-assigned-identity) for more information.||False|
|os_type| A string indicating the Operating System type for this function app. ||False|
|site_config| A `site_config` object as defined below.||False|
|source_control| A `source_control` block, as defined below.| Block |False|
|storage_account|The `storage_account` block as defined below.|Block|True|
|storage_account_access_key| The access key which will be used to access the backend storage account for the Function App.||False|
|version| The runtime version associated with the Function App. Defaults to `~1`.||False|
|tags| A mapping of tags to assign to the resource.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|app_service_plan| key | Key for  app_service_plan||| Required if  |
|app_service_plan| lz_key |Landing Zone Key in wich the app_service_plan is located|||True|
|app_service_plan| id | The id of the app_service_plan |||True|
|auth_settings|enabled| Is Authentication enabled?|||True|
|auth_settings|active_directory| A `active_directory` block as defined below.|||False|
|active_directory|client_id| The Client ID of this relying party application. Enables OpenIDConnection authentication with Azure Active Directory.|||True|
|active_directory|client_secret| The Client Secret of this relying party application. If no secret is provided, implicit flow will be used.|||False|
|active_directory|allowed_audiences||||False|
|auth_settings|additional_login_params| Login parameters to send to the OpenID Connect authorization endpoint when a user logs in. Each parameter must be in the form "key=value".|||False|
|auth_settings|allowed_external_redirect_urls| External URLs that can be redirected to as part of logging in or logging out of the app.|||False|
|auth_settings|default_provider| The default provider to use when multiple providers have been set up. Possible values are `AzureActiveDirectory`, `Facebook`, `Google`, `MicrosoftAccount` and `Twitter`.|||False|
|auth_settings|facebook| A `facebook` block as defined below.|||False|
|facebook|app_id| The App ID of the Facebook app used for login|||True|
|facebook|app_secret| The App Secret of the Facebook app used for Facebook Login.|||True|
|facebook|oauth_scopes||||False|
|auth_settings|google| A `google` block as defined below.|||False|
|google|client_id| The OpenID Connect Client ID for the Google web application.|||True|
|google|client_secret| The client secret associated with the Google web application.|||True|
|google|oauth_scopes||||False|
|auth_settings|issuer| Issuer URI. When using Azure Active Directory, this value is the URI of the directory tenant, e.g. https://sts.windows.net/{tenant-guid}/.|||False|
|auth_settings|microsoft| A `microsoft` block as defined below.|||False|
|microsoft|client_id| The OAuth 2.0 client ID that was created for the app used for authentication.|||True|
|microsoft|client_secret| The OAuth 2.0 client secret that was created for the app used for authentication.|||True|
|microsoft|oauth_scopes||||False|
|auth_settings|runtime_version| The runtime version of the Authentication/Authorization module.|||False|
|auth_settings|token_refresh_extension_hours| The number of hours after session token expiration that a session token can be used to call the token refresh API. Defaults to 72.|||False|
|auth_settings|token_store_enabled| If enabled the module will durably store platform-specific security tokens that are obtained during login flows. Defaults to false.|||False|
|auth_settings|twitter| A `twitter` block as defined below.|||False|
|auth_settings|unauthenticated_client_action| The action to take when an unauthenticated client attempts to access the app. Possible values are `AllowAnonymous` and `RedirectToLoginPage`.|||False|
|identity|type| Specifies the identity type of the Function App. Possible values are `SystemAssigned` (where Azure will generate a Service Principal for you), `UserAssigned` where you can specify the Service Principal IDs in the `identity_ids` field, and `SystemAssigned, UserAssigned` which assigns both a system managed identity as well as the specified user assigned identities.|||True|
|identity|identity_ids| Specifies a list of user managed identity ids to be assigned. Required if `type` is `UserAssigned`.|||False|
|source_control|repo_url| The URL of the source code repository.|||True|
|source_control|branch| The branch of the remote repository to use. Defaults to 'master'. |||False|
|source_control|manual_integration| Limits to manual integration. Defaults to `false` if not specified. |||False|
|source_control|rollback_enabled| Enable roll-back for the repository. Defaults to `false` if not specified.|||False|
|source_control|use_mercurial| Use Mercurial if `true`, otherwise uses Git. |||False|
|storage_account| key | Key for  storage_account||| Required if  |
|storage_account| lz_key |Landing Zone Key in wich the storage_account is located|||True|
|storage_account| name | The name of the storage_account |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Function App|||
|custom_domain_verification_id|An identifier used by App Service to perform domain ownership verification via DNS TXT record. |||
|default_hostname|The default hostname associated with the Function App - such as `mysite.azurewebsites.net`|||
|outbound_ip_addresses|A comma separated list of outbound IP addresses - such as `52.23.25.3,52.143.43.12`|||
|possible_outbound_ip_addresses|A comma separated list of outbound IP addresses - such as `52.23.25.3,52.143.43.12,52.143.43.17` - not all of which are necessarily in use. Superset of `outbound_ip_addresses`.|||
|identity|An `identity` block as defined below, which contains the Managed Service Identity information for this App Service.|||
|site_credential|A `site_credential` block as defined below, which contains the site-level credentials used to publish to this App Service.|||
|kind|The Function App kind - such as `functionapp,linux,container`|||
