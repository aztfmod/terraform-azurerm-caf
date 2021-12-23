module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# app_service

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the App Service. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
| region |The region_key where the resource will be deployed|String|True|
|app_service_plan|The `app_service_plan` block as defined below.|Block|True|
|app_settings| A key-value pair of App Settings.||False|
|auth_settings| A `auth_settings` block as defined below.| Block |False|
|backup| A `backup` block as defined below.| Block |False|
|connection_string| One or more `connection_string` blocks as defined below.| Block |False|
|client_affinity_enabled| Should the App Service send session affinity cookies, which route client requests in the same session to the same instance?||False|
|client_cert_enabled| Does the App Service require client certificates for incoming requests? Defaults to `false`.||False|
|client_cert_mode| Mode of client certificates for this App Service. Possible values are `Required`, `Optional` and `OptionalInteractiveUser`. If this parameter is set, `client_cert_enabled` must be set to `true`, otherwise this parameter is ignored.||False|
|enabled| Is the App Service Enabled?||False|
|identity| An `identity` block as defined below.| Block |False|
|https_only| Can the App Service only be accessed via HTTPS? Defaults to `false`.||False|
|key_vault_reference_identity_id| The User Assigned Identity Id used for looking up KeyVault secrets. The identity must be assigned to the application. [For more information see - Access vaults with a user-assigned identity](https://docs.microsoft.com/en-us/azure/app-service/app-service-key-vault-references#access-vaults-with-a-user-assigned-identity)||False|
|logs| A `logs` block as defined below.| Block |False|
|storage_account| One or more `storage_account` blocks as defined below.| Block |False|
|site_config| A `site_config` block as defined below.| Block |False|
|source_control| A Source Control block as defined below| Block |False|
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
|backup|name||||False|
|backup|enabled| Is this Backup enabled?|||True|
|backup|storage_account_url||||False|
|backup|schedule| A `schedule` block as defined below.|||False|
|schedule|frequency_interval| Sets how often the backup should be executed.|||True|
|schedule|frequency_unit| Sets the unit of time for how often the backup should be executed. Possible values are `Day` or `Hour`.|||False|
|schedule|keep_at_least_one_backup| Should at least one backup always be kept in the Storage Account by the Retention Policy, regardless of how old it is?|||False|
|schedule|retention_period_in_days| Specifies the number of days after which Backups should be deleted.|||False|
|schedule|start_time| Sets when the schedule should start working.|||False|
|connection_string|name| The name of the Connection String.|||True|
|connection_string|type| The type of the Connection String. Possible values are `APIHub`, `Custom`, `DocDb`, `EventHub`, `MySQL`, `NotificationHub`, `PostgreSQL`, `RedisCache`, `ServiceBus`, `SQLAzure` and  `SQLServer`.|||True|
|connection_string|value| The value for the Connection String.|||True|
|identity|type| Specifies the identity type of the App Service. Possible values are `SystemAssigned` (where Azure will generate a Service Principal for you), `UserAssigned` where you can specify the Service Principal IDs in the `identity_ids` field, and `SystemAssigned, UserAssigned` which assigns both a system managed identity as well as the specified user assigned identities.|||True|
|identity|identity_ids| Specifies a list of user managed identity ids to be assigned. Required if `type` is `UserAssigned`.|||False|
|logs|application_logs| An `application_logs` block as defined below.|||False|
|application_logs|azure_blob_storage| An `azure_blob_storage` block as defined below.|||False|
|azure_blob_storage|level| The level at which to log. Possible values include `Error`, `Warning`, `Information`, `Verbose` and `Off`. **NOTE:** this field is not available for `http_logs`|||True|
|azure_blob_storage|sas_url| The URL to the storage container with a shared access signature token appended. |||True|
|azure_blob_storage|retention_in_days| The number of days to retain logs for.|||True|
|application_logs|file_system_level| Log level for filesystem based logging. Supported values are `Error`, `Information`, `Verbose`, `Warning` and `Off`. Defaults to `Off`.|||False|
|logs|http_logs| An `http_logs` block as defined below.|||False|
|http_logs|file_system| A `file_system` block as defined below.|||False|
|file_system|retention_in_days| The number of days to retain logs for.|||True|
|file_system|retention_in_mb| The maximum size in megabytes that http log files can use before being removed.|||True|
|http_logs|azure_blob_storage| An `azure_blob_storage` block as defined below.|||False|
|azure_blob_storage|level| The level at which to log. Possible values include `Error`, `Warning`, `Information`, `Verbose` and `Off`. **NOTE:** this field is not available for `http_logs`|||True|
|azure_blob_storage|sas_url| The URL to the storage container with a shared access signature token appended. |||True|
|azure_blob_storage|retention_in_days| The number of days to retain logs for.|||True|
|logs|detailed_error_messages_enabled| Should `Detailed error messages` be enabled on this App Service? Defaults to `false`.|||False|
|logs|failed_request_tracing_enabled| Should `Failed request tracing` be enabled on this App Service? Defaults to `false`.|||False|
|storage_account|name| The name of the storage account identifier.|||True|
|storage_account|type| The type of storage. Possible values are `AzureBlob` and `AzureFiles`.|||True|
|storage_account|account_name| The name of the storage account.|||True|
|storage_account|share_name| The name of the file share (container name, for Blob storage).|||True|
|storage_account|access_key| The access key for the storage account.|||True|
|storage_account|mount_path| The path to mount the storage within the site's runtime environment.|||False|
|site_config|acr_use_managed_identity_credentials| Are Managed Identity Credentials used for Azure Container Registry pull|||False|
|site_config|acr_user_managed_identity_client_id| If using User Managed Identity, the User Managed Identity Client Id|||False|
|site_config|always_on| Should the app be loaded at all times? Defaults to `false`.|||False|
|site_config|app_command_line| App command line to launch, e.g. `/sbin/myserver -b 0.0.0.0`.|||False|
|site_config|cors| A `cors` block as defined below.|||False|
|cors|allowed_origins| A list of origins which should be able to make cross-origin calls. `*` can be used to allow all calls.|||False|
|cors|support_credentials| Are credentials supported?|||False|
|site_config|default_documents| The ordering of default documents to load, if an address isn't specified.|||False|
|site_config|dotnet_framework_version| The version of the .net framework's CLR used in this App Service. Possible values are `v2.0` (which will use the latest version of the .net framework for the .net CLR v2 - currently `.net 3.5`), `v4.0` (which corresponds to the latest version of the .net CLR v4 - which at the time of writing is `.net 4.7.1`), `v5.0` and `v6.0`. [For more information on which .net CLR version to use based on the .net framework you're targeting - please see this table](https://en.wikipedia.org/wiki/.NET_Framework_version_history#Overview). Defaults to `v4.0`.|||False|
|site_config|ftps_state| State of FTP / FTPS service for this App Service. Possible values include: `AllAllowed`, `FtpsOnly` and `Disabled`.|||False|
|site_config|health_check_path| The health check path to be pinged by App Service. [For more information - please see App Service health check announcement](https://azure.github.io/AppService/2020/08/24/healthcheck-on-app-service.html).|||False|
|site_config|number_of_workers| The scaled number of workers (for per site scaling) of this App Service. Requires that `per_site_scaling` is enabled on the `azurerm_app_service_plan`. [For more information - please see Microsoft documentation on high-density hosting](https://docs.microsoft.com/en-us/azure/app-service/manage-scale-per-app).|||False|
|site_config|http2_enabled| Is HTTP2 Enabled on this App Service? Defaults to `false`.|||False|
|site_config|ip_restriction| A [List of objects](/docs/configuration/attr-as-blocks.html) representing ip restrictions as defined below.|||False|
|ip_restriction|ip_address| The IP Address used for this IP Restriction in CIDR notation.|||False|
|ip_restriction|service_tag| The Service Tag used for this IP Restriction.|||False|
|ip_restriction|virtual_network_subnet_id| The Virtual Network Subnet ID used for this IP Restriction.|||False|
|ip_restriction|name| The name for this IP Restriction.|||False|
|ip_restriction|priority| The priority for this IP Restriction. Restrictions are enforced in priority order. By default, priority is set to 65000 if not specified.|||False|
|ip_restriction|action| Does this restriction `Allow` or `Deny` access for this IP range. Defaults to `Allow`.  |||False|
|ip_restriction|headers| The headers for this specific `ip_restriction` as defined below.|||False|
|headers|x_azure_fdid| A list of allowed Azure FrontDoor IDs in UUID notation with a maximum of 8.|||False|
|headers|x_fd_health_probe| A list to allow the Azure FrontDoor health probe header. Only allowed value is "1".|||False|
|headers|x_forwarded_for| A list of allowed 'X-Forwarded-For' IPs in CIDR notation with a maximum of 8|||False|
|headers|x_forwarded_host| A list of allowed 'X-Forwarded-Host' domains with a maximum of 8.|||False|
|site_config|scm_use_main_ip_restriction|  IP security restrictions for scm to use main. Defaults to false.  |||False|
|site_config|scm_ip_restriction| A [List of objects](/docs/configuration/attr-as-blocks.html) representing ip restrictions as defined below.|||False|
|scm_ip_restriction|ip_address| The IP Address used for this IP Restriction in CIDR notation.|||False|
|scm_ip_restriction|service_tag| The Service Tag used for this IP Restriction.|||False|
|scm_ip_restriction|virtual_network_subnet_id| The Virtual Network Subnet ID used for this IP Restriction.|||False|
|scm_ip_restriction|name| The name for this IP Restriction.|||False|
|scm_ip_restriction|priority| The priority for this IP Restriction. Restrictions are enforced in priority order. By default, priority is set to 65000 if not specified.  |||False|
|scm_ip_restriction|action| Allow or Deny access for this IP range. Defaults to Allow.|||False|
|scm_ip_restriction|headers| The headers for this specific `scm_ip_restriction` as defined below.|||False|
|headers|x_azure_fdid| A list of allowed Azure FrontDoor IDs in UUID notation with a maximum of 8.|||False|
|headers|x_fd_health_probe| A list to allow the Azure FrontDoor health probe header. Only allowed value is "1".|||False|
|headers|x_forwarded_for| A list of allowed 'X-Forwarded-For' IPs in CIDR notation with a maximum of 8|||False|
|headers|x_forwarded_host| A list of allowed 'X-Forwarded-Host' domains with a maximum of 8.|||False|
|site_config|java_version| The version of Java to use. If specified `java_container` and `java_container_version` must also be specified. Possible values are `1.7`, `1.8` and `11` and their specific versions - except for Java 11 (e.g. `1.7.0_80`, `1.8.0_181`, `11`)|||False|
|site_config|java_container| The Java Container to use. If specified `java_version` and `java_container_version` must also be specified. Possible values are `JAVA`, `JETTY`, and `TOMCAT`.|||False|
|site_config|java_container_version| The version of the Java Container to use. If specified `java_version` and `java_container` must also be specified.|||False|
|site_config|local_mysql_enabled| Is "MySQL In App" Enabled? This runs a local MySQL instance with your app and shares resources from the App Service plan.|||False|
|site_config|linux_fx_version| Linux App Framework and version for the App Service. Possible options are a Docker container (`DOCKER|<user/image:tag>`), a base-64 encoded Docker Compose file (`COMPOSE|${filebase64("compose.yml")}`) or a base-64 encoded Kubernetes Manifest (`KUBE|${filebase64("kubernetes.yml")}`).|||False|
|site_config|windows_fx_version| The Windows Docker container image (`DOCKER|<user/image:tag>`)|||False|
|site_config|managed_pipeline_mode| The Managed Pipeline Mode. Possible values are `Integrated` and `Classic`. Defaults to `Integrated`.|||False|
|site_config|min_tls_version| The minimum supported TLS version for the app service. Possible values are `1.0`, `1.1`, and `1.2`. Defaults to `1.2` for new app services.|||False|
|site_config|php_version| The version of PHP to use in this App Service. Possible values are `5.5`, `5.6`, `7.0`, `7.1`, `7.2`, `7.3` and `7.4`.|||False|
|site_config|python_version| The version of Python to use in this App Service. Possible values are `2.7` and `3.4`.|||False|
|site_config|remote_debugging_enabled| Is Remote Debugging Enabled? Defaults to `false`.|||False|
|site_config|remote_debugging_version| Which version of Visual Studio should the Remote Debugger be compatible with? Possible values are `VS2012`, `VS2013`, `VS2015` and `VS2017`.|||False|
|site_config|scm_type| The type of Source Control enabled for this App Service. Defaults to `None`. Possible values are: `BitbucketGit`, `BitbucketHg`, `CodePlexGit`, `CodePlexHg`, `Dropbox`, `ExternalGit`, `ExternalHg`, `GitHub`, `LocalGit`, `None`, `OneDrive`, `Tfs`, `VSO`, and `VSTSRM`|||False|
|site_config|use_32_bit_worker_process| Should the App Service run in 32 bit mode, rather than 64 bit mode?|||False|
|site_config|vnet_route_all_enabled| Should all outbound traffic to have Virtual Network Security Groups and User Defined Routes applied? Defaults to `false`.|||False|
|site_config|websockets_enabled| Should WebSockets be enabled?|||False|
|source_control|repo_url| The URL of the source code repository.|||True|
|source_control|branch| The branch of the remote repository to use. Defaults to 'master'. |||False|
|source_control|manual_integration| Limits to manual integration. Defaults to `false` if not specified. |||False|
|source_control|rollback_enabled| Enable roll-back for the repository. Defaults to `false` if not specified.|||False|
|source_control|use_mercurial| Use Mercurial if `true`, otherwise uses Git. |||False|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the App Service.|||
|custom_domain_verification_id|An identifier used by App Service to perform domain ownership verification via DNS TXT record.|||
|default_site_hostname|The Default Hostname associated with the App Service - such as `mysite.azurewebsites.net`|||
|outbound_ip_addresses|A comma separated list of outbound IP addresses - such as `52.23.25.3,52.143.43.12`|||
|outbound_ip_address_list|A list of outbound IP addresses - such as `["52.23.25.3", "52.143.43.12"]`|||
|possible_outbound_ip_addresses|A comma separated list of outbound IP addresses - such as `52.23.25.3,52.143.43.12,52.143.43.17` - not all of which are necessarily in use. Superset of `outbound_ip_addresses`.|||
|possible_outbound_ip_address_list|A list of outbound IP addresses - such as `["52.23.25.3", "52.143.43.12", "52.143.43.17"]` - not all of which are necessarily in use. Superset of `outbound_ip_address_list`.|||
|source_control|A `source_control` block as defined below, which contains the Source Control information when `scm_type` is set to `LocalGit`.|||
|site_credential|A `site_credential` block as defined below, which contains the site-level credentials used to publish to this App Service.|||
|identity|An `identity` block as defined below, which contains the Managed Service Identity information for this App Service.|||
