
resource "azurecaf_name" "plan" {
  name          = var.name
  resource_type = "azurerm_function_app"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_linux_function_app" "linux_function_app" {
  #To avoid redeploy with existing customer
  lifecycle {
    ignore_changes = [name]
  }
  name                               = azurecaf_name.plan.result
  location                           = local.location
  resource_group_name                = local.resource_group_name
  service_plan_id                    = var.service_plan_id
  builting_logging_enabled           = try(var.settings.builting_logging_enabled, true)
  client_certificate_enabled         = try(var.settings.client_certificate_enabled, null)
  client_certificate_mode            = try(var.settings.client_certificate_mode, null)
  client_certificate_exclusion_paths = try(var.settings.client_certificate_exclusion_paths, null)
  daily_memory_time_quota            = try(var.settings.daily_memory_time_quota, 0)
  enabled                            = try(var.settings.enabled, null)
  content_share_force_disabled       = try(var.settings.content_share_force_disabled, null)
  functions_extension_version        = try(var.settings.functions_extension_version, "~4")
  https_only                         = try(var.settings.https_only, false)
  public_network_access_enabled      = try(var.settings.public_network_access_enabled, null)
  storage_account_access_key         = try(var.settings.storage_account_access_key, null)
  dynamic "storage_account_access_key" {
    for_each = var.settings.storage_account_access_key != null ? [var.settings.storage_account_access_key] : []
    content {
      storage_account_access_key = storage_account_access_key.value
    }
  }
  storage_account_name = try(var.settings.storage_account_name, null)

  dynamic "storage_uses_managed_identity" {
    for_each = var.settings.storage_uses_managed_identity != null ? [var.settings.storage_uses_managed_identity] : []
    content {
      storage_uses_managed_identity = storage_uses_managed_identity.value
    }
  }

  dynamic "storage_key_vault_secret_id" {
    for_each = var.settings.storage_key_vault_secret_id != null ? [var.settings.storage_key_vault_secret_id] : []
    content {
      storage_key_vault_secret_id = storage_key_vault_secret_id.value
    }
  }
  dynamic "virtual_network_subnet_id" {
    for_each = var.settings.virtual_network_subnet_id != null ? [var.settings.virtual_network_subnet_id] : []
    content {
      virtual_network_subnet_id = virtual_network_subnet_id.value
    }
  }
  zip_deploy_enabled = try(var.settings.zip_deploy_enabled, null)
  tags               = merge(local.tags, try(var.settings.tags, {}))




  app_settings = local.app_settings




  dynamic "auth_settings" {
    for_each = lookup(var.settings, "auth_settings", {}) != {} ? [1] : []

    content {
      enabled                        = lookup(var.settings.auth_settings, "enabled", false)
      additional_login_params        = lookup(var.settings.auth_settings, "additional_login_params", null)
      allowed_external_redirect_urls = lookup(var.settings.auth_settings, "allowed_external_redirect_urls", null)
      default_provider               = lookup(var.settings.auth_settings, "default_provider", null)
      issuer                         = lookup(var.settings.auth_settings, "issuer", null)
      runtime_version                = lookup(var.settings.auth_settings, "runtime_version", null)
      token_refresh_extension_hours  = lookup(var.settings.auth_settings, "token_refresh_extension_hours", null)
      token_store_enabled            = lookup(var.settings.auth_settings, "token_store_enabled", null)
      unauthenticated_client_action  = lookup(var.settings.auth_settings, "unauthenticated_client_action", null)

      dynamic "active_directory" {
        for_each = lookup(var.settings.auth_settings, "active_directory", {}) != {} ? [1] : []

        content {
          client_id         = var.settings.auth_settings.active_directory.client_id
          client_secret     = lookup(var.settings.auth_settings.active_directory, "client_secret", null)
          allowed_audiences = lookup(var.settings.auth_settings.active_directory, "allowed_audiences", null)
        }
      }

      dynamic "facebook" {
        for_each = lookup(var.settings.auth_settings, "facebook", {}) != {} ? [1] : []

        content {
          app_id       = var.settings.auth_settings.facebook.app_id
          app_secret   = var.settings.auth_settings.facebook.app_secret
          oauth_scopes = lookup(var.settings.auth_settings.facebook, "oauth_scopes", null)
        }
      }

      dynamic "google" {
        for_each = lookup(var.settings.auth_settings, "google", {}) != {} ? [1] : []

        content {
          client_id     = var.settings.auth_settings.google.client_id
          client_secret = var.settings.auth_settings.google.client_secret
          oauth_scopes  = lookup(var.settings.auth_settings.google, "oauth_scopes", null)
        }
      }

      dynamic "microsoft" {
        for_each = lookup(var.settings.auth_settings, "microsoft", {}) != {} ? [1] : []

        content {
          client_id     = var.settings.auth_settings.microsoft.client_id
          client_secret = var.settings.auth_settings.microsoft.client_secret
          oauth_scopes  = lookup(var.settings.auth_settings.microsoft, "oauth_scopes", null)
        }
      }

      dynamic "twitter" {
        for_each = lookup(var.settings.auth_settings, "twitter", {}) != {} ? [1] : []

        content {
          consumer_key    = var.settings.auth_settings.twitter.consumer_key
          consumer_secret = var.settings.auth_settings.twitter.consumer_secret
        }
      }
    }
  }

  dynamic "auth_settings_v2" {
    for_each = lookup(var.settings, "auth_settings_v2", {}) != {} ? [1] : []
    content {
      auth_enabled                            = lookup(local.auth_settings_v2, "auth_enabled", false)
      runtime_version                         = lookup(local.auth_settings_v2, "runtime_version", "~1")
      config_file_path                        = lookup(local.auth_settings_v2, "config_file_path", null)
      require_authentication                  = lookup(local.auth_settings_v2, "require_authentication", null)
      unauthenticated_action                  = lookup(local.auth_settings_v2, "unauthenticated_action", RedirectRoLoginPage)
      default_provider                        = lookup(local.auth_settings_v2, "default_provider", null)
      exclude_paths                           = lookup(local.auth_settings_v2, "exclude_paths", null)
      require_https                           = lookup(local.auth_settings_v2, "require_https", null)
      http_route_api_prefix                   = lookup(local.auth_settings_v2, "http_route_api_prefix", "/.auth")
      forward_proxy_convention                = lookup(local.auth_settings_v2, "forward_proxy_convention", null)
      forward_proxy_custom_host_header_name   = lookup(local.auth_settings_v2, "forward_proxy_custom_host_header_name", null)
      forward_proxy_custom_scheme_header_name = lookup(local.auth_settings_v2, "forward_proxy_custom_scheme_header_name", null)
      dynamic "apple_v2" {
        for_each = lookup(var.settings.auth_settings, "apple_v2", {}) != {} ? [1] : []
        content {
          client_id = lookup(local.auth_settings_v2.apple_v2, "client_id", null)

        }
      }

      dynamic "active_directory_v2" {
        for_each = lookup(var.settings.auth_settings, "active_directory_v2", {}) != {} ? [1] : []

        content {
          #client_id - (Required) The ID of the Client to use to authenticate with Azure Active Directory.
          #tenant_auth_endpoint - (Required) The Azure Tenant Endpoint for the Authenticating Tenant. e.g. https://login.microsoftonline.com/v2.0/{tenant-guid}/
          #client_secret_setting_name - (Optional) The App Setting name that contains the client secret of the Client.
          #client_secret_certificate_thumbprint - (Optional) The thumbprint of the certificate used for signing purposes.
          #jwt_allowed_groups = (Optional) A list of Allowed Groups in the JWT Claim.
          #jwt_allowed_client_applications = (Optional) A list of Allowed Client Applications in the JWT Claim.      
          #www_authentication_disabled = (Optional) Should the www-authenticate provider should be omitted from the request? Defaults to false         
          #allowed_groups = (Optional) The list of allowed Group Names for the Default Authorisation Policy.        
          #allowed_identities = (Optional) The list of allowed Identities for the Default Authorisation Policy.
          #allowed_applications = (Optional) The list of allowed Applications for the Default Authorisation Policy.       
          #login_parameters = (Optional) A map of key-value pairs to send to the Authorisation Endpoint when a user logs in.
          #allowed_audiences = (Optional) Specifies a list of Allowed audience values to consider when validating JWTs issued by Azure Active Directory.
          client_id                            = local.auth_settings_v2.active_directory_v2.client_id
          tenant_auth_endpoint                 = local.auth_settings_v2.active_directory_v2.tenant_auth_endpoint
          client_secret_setting_name           = lookup(local.auth_settings_v2.active_directory_v2, "client_secret_setting_name", null)
          client_secret_certificate_thumbprint = lookup(local.auth_settings_v2.active_directory_v2, "client_secret_certificate_thumbprint", null)
          jwt_allowed_groups                   = lookup(local.auth_settings_v2.active_directory_v2, "jwt_allowed_groups", null)
          jwt_allowed_client_applications      = lookup(local.auth_settings_v2.active_directory_v2, "jwt_allowed_client_applications", null)
          www_authentication_disabled          = lookup(local.auth_settings_v2.active_directory_v2, "www_authentication_disabled", false)
          allowed_groups                       = lookup(local.auth_settings_v2.active_directory_v2, "allowed_groups", null)
          allowed_identities                   = lookup(local.auth_settings_v2.active_directory_v2, "allowed_identities", null)
          allowed_applications                 = lookup(local.auth_settings_v2.active_directory_v2, "allowed_applications", null)
          login_parameters                     = lookup(local.auth_settings_v2.active_directory_v2, "login_parameters", null)
          allowed_audiences                    = lookup(local.auth_settings_v2.active_directory_v2, "allowed_audiences", null)
        }
      }
      dynamic "azure_static_web_app_v2" {
        for_each = lookup(var.settings.auth_settings, "azure_static_web_app_v2", {}) != {} ? [1] : []
        content {
          client_id = local.auth_settings_v2.azure_static_web_app_v2.client_id
        }
      }

      dynamic "custom_oidc_v2" {
        for_each = lookup(var.settings.auth_settings, "custom_oidc_v2", {}) != {} ? [1] : []
        content {
          #client_id - (Required) The ID of the Client to use to authenticate with the Custom OIDC.
          #openid_configuration_endpoint - (Required) The app setting name that contains the client_secret value used for the Custom OIDC Login.
          #name_claim_type - (Optional) The name of the claim that contains the users name.
          #scopes - (Optional) The list of the scopes that should be requested while authenticating.
          #client_credential_method - The Client Credential Method used.
          #client_secret_setting_name - The App Setting name that contains the secret for this Custom OIDC Client. This is generated from name above and suffixed with _PROVIDER_AUTHENTICATION_SECRET.
          #authorisation_endpoint - The endpoint to make the Authorisation Request as supplied by openid_configuration_endpoint response.
          #token_endpoint - The endpoint used to request a Token as supplied by openid_configuration_endpoint response.
          #issuer_endpoint - The endpoint that issued the Token as supplied by openid_configuration_endpoint response.
          #certification_uri - The endpoint that provides the keys necessary to validate the token as supplied by openid_configuration_endpoint response.
          client_id                     = local.auth_settings_v2.custom_oidc_v2.client_id
          openid_configuration_endpoint = local.auth_settings_v2.custom_oidc_v2.openid_configuration_endpoint
          name_claim_type               = lookup(local.auth_settings_v2.custom_oidc_v2, "name_claim_type", null)
          scopes                        = lookup(local.auth_settings_v2.custom_oidc_v2, "scopes", null)
          client_credential_method      = lookup(local.auth_settings_v2.custom_oidc_v2, "client_credential_method", null)
          client_secret_setting_name    = lookup(local.auth_settings_v2.custom_oidc_v2, "client_secret_setting_name", null)
          authorisation_endpoint        = lookup(local.auth_settings_v2.custom_oidc_v2, "authorisation_endpoint", null)
          token_endpoint                = lookup(local.auth_settings_v2.custom_oidc_v2, "token_endpoint", null)
          issuer_endpoint               = lookup(local.auth_settings_v2.custom_oidc_v2, "issuer_endpoint", null)
          certification_uri             = lookup(local.auth_settings_v2.custom_oidc_v2, "certification_uri", null)

        }

      }

      dynamic "facebook_v2" {
        for_each = lookup(local.auth_settings_v2, "facebook_v2", {}) != {} ? [1] : []

        content {
          #app_id - (Required) The App ID of the Facebook app used for login.
          #app_secret_setting_name - (Required) The app setting name that contains the app_secret value used for Facebook Login.
          #NOTE: A setting with this name must exist in app_settings to function correctly.
          #graph_api_version - (Optional) The version of the Facebook API to be used while logging in.
          #login_scopes - (Optional) The list of scopes that should be requested as part of Facebook Login authentication.
          app_id                  = local.auth_settings_v2.facebook_v2.app_id
          app_secret_setting_name = local.auth_settings_v2.facebook_v2.app_secret_setting_name
          graph_api_version       = lookup(local.auth_settings_v2.facebook_v2, "graph_api_version", null)
          login_scopes            = lookup(local.auth_settings_v2.facebook_v2, "login_scopes", null)
        }
      }

      #dynamic A github_v2 block supports the following:
      #client_id - (Required) The ID of the GitHub app used for login..
      #client_secret_setting_name - (Required) The app setting name that contains the client_secret value used for GitHub Login.
      #NOTE:A setting with this name must exist in app_settings to function correctly.
      #login_scopes - (Optional) The list of OAuth 2.0 scopes that should be requested as part of GitHub Login authentication.

      dynamic "github_v2" {
        for_each = lookup(local.auth_settings_v2, "github_v2", {}) != {} ? [1] : []
        content {
          client_id                  = local.auth_settings_v2.github_v2.client_id
          client_secret_setting_name = local.auth_settings_v2.github_v2.client_secret_setting_name
          login_scopes               = lookup(local.auth_settings_v2.github_v2, "login_scopes", null)
        }
      }

      #A google_v2 block supports the following:
      #client_id - (Required) The OpenID Connect Client ID for the Google web application.
      #client_secret_setting_name - (Required) The app setting name that contains the client_secret value used for Google Login.
      #NOTE:A setting with this name must exist in app_settings to function correctly.
      #allowed_audiences - (Optional) Specifies a list of Allowed Audiences that should be requested as part of Google Sign-In authentication.
      #login_scopes - (Optional) The list of OAuth 2.0 scopes that should be requested as part of Google Sign-In authentication.

      dynamic "google_v2" {
        for_each = lookup(local.auth_settings_v2, "google_v2", {}) != {} ? [1] : []
        content {
          client_id                  = local.auth_settings_v2.google_v2.client_id
          client_secret_setting_name = local.auth_settings_v2.google_v2.client_secret_setting_name
          allowed_audiences          = lookup(local.auth_settings_v2.google_v2, "allowed_audiences", null)
          login_scopes               = lookup(local.auth_settings_v2.google_v2, "login_scopes", null)
        }
      }

      #A microsoft_v2 block supports the following:
      #client_id - (Required) The OAuth 2.0 client ID that was created for the app used for authentication.
      #client_secret_setting_name - (Required) The app setting name containing the OAuth 2.0 client secret that was created for the app used for authentication.
      #NOTE: A setting with this name must exist in app_settings to function correctly.
      #allowed_audiences - (Optional) Specifies a list of Allowed Audiences that will be requested as part of Microsoft Sign-In authentication.
      #login_scopes - (Optional) The list of Login scopes that should be requested as part of Microsoft Account authentication.

      dynamic "microsoft_v2" {
        for_each = lookup(local.auth_settings_v2, "microsoft_v2", {}) != {} ? [1] : []
        content {
          client_id                  = local.auth_settings_v2.microsoft_v2.client_id
          client_secret_setting_name = local.auth_settings_v2.microsoft_v2.client_secret_setting_name
          allowed_audiences          = lookup(local.auth_settings_v2.microsoft_v2, "allowed_audiences", null)
          login_scopes               = lookup(local.auth_settings_v2.microsoft_v2, "login_scopes", null)
        }
      }

      #A twitter_v2 block supports the following:
      #consumer_key - (Required) The OAuth 1.0a consumer key of the Twitter application used for sign-in.
      #consumer_secret_setting_name - (Required) The app setting name that contains the OAuth 1.0a consumer secret of the Twitter application used for sign-in.  

      dynamic "twitter_v2" {
        for_each = lookup(local.auth_settings_v2, "twitter_v2", {}) != {} ? [1] : []
        content {
          consumer_key                 = local.auth_settings_v2.twitter_v2.consumer_key
          consumer_secret_setting_name = local.auth_settings_v2.twitter_v2.consumer_secret_setting_name
        }
      }
      /* A login block supports the following:

logout_endpoint - (Optional) The endpoint to which logout requests should be made.

token_store_enabled - (Optional) Should the Token Store configuration Enabled. Defaults to false

token_refresh_extension_time - (Optional) The number of hours after session token expiration that a session token can be used to call the token refresh API. Defaults to 72 hours.

token_store_path - (Optional) The directory path in the App Filesystem in which the tokens will be stored.

token_store_sas_setting_name - (Optional) The name of the app setting which contains the SAS URL of the blob storage containing the tokens.

preserve_url_fragments_for_logins - (Optional) Should the fragments from the request be preserved after the login request is made. Defaults to false.

allowed_external_redirect_urls - (Optional) External URLs that can be redirected to as part of logging in or logging out of the app. This is an advanced setting typically only needed by Windows Store application backends.

Note:
URLs within the current domain are always implicitly allowed.

cookie_expiration_convention - (Optional) The method by which cookies expire. Possible values include: FixedTime, and IdentityProviderDerived. Defaults to FixedTime.

cookie_expiration_time - (Optional) The time after the request is made when the session cookie should expire. Defaults to 08:00:00.

validate_nonce - (Optional) Should the nonce be validated while completing the login flow. Defaults to true.

nonce_expiration_time - (Optional) The time after the request is made when the nonce should expire. Defaults to 00:05:00. */

      dynamic "login" {
        for_each = lookup(local.auth_settings_v2, "login", {}) != {} ? [1] : []
        content {
          logout_endpoint                   = lookup(local.auth_settings_v2.login, "logout_endpoint", null)
          token_store_enabled               = lookup(local.auth_settings_v2.login, "token_store_enabled", null)
          token_refresh_extension_time      = lookup(local.auth_settings_v2.login, "token_refresh_extension_time", null)
          token_store_path                  = lookup(local.auth_settings_v2.login, "token_store_path", null)
          token_store_sas_setting_name      = lookup(local.auth_settings_v2.login, "token_store_sas_setting_name", null)
          preserve_url_fragments_for_logins = lookup(local.auth_settings_v2.login, "preserve_url_fragments_for_logins", null)
          allowed_external_redirect_urls    = lookup(local.auth_settings_v2.login, "allowed_external_redirect_urls", null)
          cookie_expiration_convention      = lookup(local.auth_settings_v2.login, "cookie_expiration_convention", null)
          cookie_expiration_time            = lookup(local.auth_settings_v2.login, "cookie_expiration_time", null)
          validate_nonce                    = lookup(local.auth_settings_v2.login, "validate_nonce", null)
          nonce_expiration_time             = lookup(local.auth_settings_v2.login, "nonce_expiration_time", null)
        }

      }
    }

  }
  /*
  A site_config block supports the following:

always_on - (Optional) If this Linux Web App is Always On enabled. Defaults to false.
NOTE:when running in a Consumption or Premium Plan, always_on feature should be turned off. Please turn it off before upgrading the service plan from standard to premium.
api_definition_url - (Optional) The URL of the API definition that describes this Linux Function App.
api_management_api_id - (Optional) The ID of the API Management API for this Linux Function App.
app_command_line - (Optional) The App command line to launch.
app_scale_limit - (Optional) The number of workers this function app can scale out to. Only applicable to apps on the Consumption and Premium plan.
application_insights_connection_string - (Optional) The Connection String for linking the Linux Function App to Application Insights.
application_insights_key - (Optional) The Instrumentation Key for connecting the Linux Function App to Application Insights.
application_stack - (Optional) An application_stack block as defined above.
Note:If this is set, there must not be an application setting FUNCTIONS_WORKER_RUNTIME.
app_service_logs - (Optional) An app_service_logs block as defined above.
container_registry_managed_identity_client_id - (Optional) The Client ID of the Managed Service Identity to use for connections to the Azure Container Registry.
container_registry_use_managed_identity - (Optional) Should connections for Azure Container Registry use Managed Identity.
cors - (Optional) A cors block as defined above.
default_documents - (Optional) Specifies a list of Default Documents for the Linux Web App.
elastic_instance_minimum - (Optional) The number of minimum instances for this Linux Function App. Only affects apps on Elastic Premium plans.
ftps_state - (Optional) State of FTP / FTPS service for this function app. Possible values include: AllAllowed, FtpsOnly and Disabled. Defaults to Disabled.
health_check_path - (Optional) The path to be checked for this function app health.
health_check_eviction_time_in_min - (Optional) The amount of time in minutes that a node can be unhealthy before being removed from the load balancer. Possible values are between 2 and 10. Only valid in conjunction with health_check_path.
http2_enabled - (Optional) Specifies if the HTTP2 protocol should be enabled. Defaults to false.
ip_restriction - (Optional) One or more ip_restriction blocks as defined above.
load_balancing_mode - (Optional) The Site load balancing mode. Possible values include: WeightedRoundRobin, LeastRequests, LeastResponseTime, WeightedTotalTraffic, RequestHash, PerSiteRoundRobin. Defaults to LeastRequests if omitted.
managed_pipeline_mode - (Optional) Managed pipeline mode. Possible values include: Integrated, Classic. Defaults to Integrated.
minimum_tls_version - (Optional) The configures the minimum version of TLS required for SSL requests. Possible values include: 1.0, 1.1, and 1.2. Defaults to 1.2.
pre_warmed_instance_count - (Optional) The number of pre-warmed instances for this function app. Only affects apps on an Elastic Premium plan.
remote_debugging_enabled - (Optional) Should Remote Debugging be enabled. Defaults to false.
remote_debugging_version - (Optional) The Remote Debugging Version. Possible values include VS2017, VS2019, and VS2022.
runtime_scale_monitoring_enabled - (Optional) Should Scale Monitoring of the Functions Runtime be enabled?
NOTE:Functions runtime scale monitoring can only be enabled for Elastic Premium Function Apps or Workflow Standard Logic Apps and requires a minimum prewarmed instance count of 1.
scm_ip_restriction - (Optional) One or more scm_ip_restriction blocks as defined above.
scm_minimum_tls_version - (Optional) Configures the minimum version of TLS required for SSL requests to the SCM site Possible values include: 1.0, 1.1, and 1.2. Defaults to 1.2.
scm_use_main_ip_restriction - (Optional) Should the Linux Function App ip_restriction configuration be used for the SCM also.
use_32_bit_worker - (Optional) Should the Linux Web App use a 32-bit worker process. Defaults to true.
vnet_route_all_enabled - (Optional) Should all outbound traffic to have NAT Gateways, Network Security Groups and User Defined Routes applied? Defaults to false.
websockets_enabled - (Optional) Should Web Sockets be enabled. Defaults to false.
worker_count - (Optional) The number of Workers for this Linux Function App.
  */

  dynamic "site_config" {
    for_each = lookup(var.settings, "site_config", {}) != {} ? [1] : []

    content {
      always_on                              = lookup(local.site_config, "always_on", null)
      api_definition_url                     = lookup(local.site_config, "api_definition_url", null)
      api_management_api_id                  = lookup(local.site_config, "api_management_api_id", null)
      app_command_line                       = lookup(local.site_config, "app_command_line", null)
      app_scale_limit                        = lookup(local.site_config, "app_scale_limit", null)
      application_insights_connection_string = lookup(local.site_config, "application_insights_connection_string", null)
      application_insights_key               = lookup(local.site_config, "application_insights_key", null)

      dynamic "application_stack" {
        for_each = lookup(local.site_config, "application_stack", {}) != {} ? [1] : []
        content {
          #docker - (Optional) One or more docker blocks as defined below.
          #dotnet_version - (Optional) The version of .NET to use. Possible values include 3.1, 6.0 and 7.0.
          #use_dotnet_isolated_runtime - (Optional) Should the DotNet process use an isolated runtime. Defaults to false.
          #java_version - (Optional) The Version of Java to use. Supported versions include 8, 11 & 17.
          #node_version - (Optional) The version of Node to run. Possible values include 12, 14, 16 and 18.
          #python_version - (Optional) The version of Python to run. Possible values are 3.11, 3.10, 3.9, 3.8 and 3.7.
          #powershell_core_version - (Optional) The version of PowerShell Core to run. Possible values are 7, and 7.2.
          #use_custom_runtime - (Optional) Should the Linux Function App use a custom runtime?
          docker                      = lookup(local.site_config.application_stack, "docker", null)
          dotnet_version              = lookup(local.site_config.application_stack, "dotnet_version", null)
          use_dotnet_isolated_runtime = lookup(local.site_config.application_stack, "use_dotnet_isolated_runtime", null)
          java_version                = lookup(local.site_config.application_stack, "java_version", null)
          node_version                = lookup(local.site_config.application_stack, "node_version", null)
          python_version              = lookup(local.site_config.application_stack, "python_version", null)
          powershell_core_version     = lookup(local.site_config.application_stack, "powershell_core_version", null)
          use_custom_runtime          = lookup(local.site_config.application_stack, "use_custom_runtime", null)
        }
      }

      dynamic "app_service_logs" {
        for_each = lookup(local.site_config, "app_service_logs", {}) != {} ? [1] : []
        content {
          #disk_quota_mb - (Optional) The amount of disk space to use for logs. Valid values are between 25 and 100. Defaults to 35.
          #retention_period_days - (Optional) The retention period for logs in days. Valid values are between 0 and 99999.(never delete).          
          disk_quota_mb         = lookup(app_service_logs.value, "disk_quota_mb", 35)
          retention_period_days = lookup(app_service_logs.value, "retention_period_days", null)
        }
      }

      container_registry_managed_identity_client_id = lookup(local.site_config, "container_registry_managed_identity_client_id", null)
      container_registry_use_managed_identity       = lookup(local.site_config, "container_registry_use_managed_identity", null)

      dynamic "cors" {
        for_each = lookup(local.site_config, "cors", {}) != {} ? [1] : []

        content {
          allowed_origins     = lookup(cors.value, "allowed_origins", null)
          support_credentials = lookup(cors.value, "support_credentials", null)
        }
      }

      default_documents                 = lookup(local.site_config, "default_documents", null)
      elastic_instance_minimum          = lookup(local.site_config, "elastic_instance_minimum", null)
      ftps_state                        = lookup(local.site_config, "ftps_state", Disabled)
      health_check_path                 = lookup(local.site_config, "health_check_path", null)
      health_check_eviction_time_in_min = lookup(local.site_config, "health_check_eviction_time_in_min", null)
      http2_enabled                     = lookup(local.site_config, "http2_enabled", false)
      /*ip_restriction - (Optional) One or more ip_restriction blocks as defined above.*/
      dynamic "ip_restriction" {
        for_each = length(local.ip_restrictions) > 0 ? local.ip_restrictions : []
        content {
          action = lookup(ip_restriction.value, "action", null)
          dynamic "headers" {
            for_each = lookup(ip_restriction.value, "headers", {}) != {} ? [1] : []
            content {
              #x_azure_fdid - (Optional) Specifies a list of Azure Front Door IDs.
              #x_fd_health_probe - (Optional) Specifies if a Front Door Health Probe should be expected. The only possible value is 1.
              #x_forwarded_for - (Optional) Specifies a list of addresses for which matching should be applied. Omitting this value means allow any.
              #x_forwarded_host - (Optional) Specifies a list of Hosts for which matching should be applied.

              x_azure_fdid      = lookup(ip_restriction.value, "x_azure_fdid", null)
              x_fd_health_probe = lookup(ip_restriction.value, "x_fd_health_probe", null)
              x_forwarded_for   = lookup(ip_restriction.value, "x_forwarded_for", null)
              x_forwarded_host  = lookup(ip_restriction.value, "x_forwarded_host", null)


            }


          }
          ip_address                = lookup(ip_restriction.value, "ip_address", null)
          name                      = lookup(ip_restriction.value, "name", null)
          priority                  = lookup(ip_restriction.value, "priority", null)
          service_tag               = lookup(ip_restriction.value, "service_tag", null)
          virtual_network_subnet_id = lookup(ip_restriction.value, "virtual_network_subnet_id", null)
        }
      }
      load_balancing_mode              = lookup(local.site_config, "load_balancing_mode", null)
      managed_pipeline_mode            = lookup(local.site_config, "managed_pipeline_mode", null)
      minimum_tls_version              = lookup(local.site_config, "minimum_tls_version", "1.2")
      pre_warmed_instance_count        = lookup(local.site_config, "pre_warmed_instance_count", null)
      remote_debugging_enabled         = lookup(local.site_config, "remote_debugging_enabled", false)
      remote_debugging_version         = lookup(local.site_config, "remote_debugging_version", null)
      runtime_scale_monitoring_enabled = lookup(local.site_config, "runtime_scale_monitoring_enabled", null)
      dynamic "scm_ip_restriction" {
        for_each = length(local.scm_ip_restrictions) > 0 ? local.scm_ip_restrictions : []
        content {
          action = lookup(scm_ip_restriction.value, "action", null)
          dynamic "headers" {
            for_each = lookup(ip_restriction.value, "headers", {}) != {} ? [1] : []
            content {
              #x_azure_fdid - (Optional) Specifies a list of Azure Front Door IDs.
              #x_fd_health_probe - (Optional) Specifies if a Front Door Health Probe should be expected. The only possible value is 1.
              #x_forwarded_for - (Optional) Specifies a list of addresses for which matching should be applied. Omitting this value means allow any.
              #x_forwarded_host - (Optional) Specifies a list of Hosts for which matching should be applied.

              x_azure_fdid      = lookup(ip_restriction.value, "x_azure_fdid", null)
              x_fd_health_probe = lookup(ip_restriction.value, "x_fd_health_probe", null)
              x_forwarded_for   = lookup(ip_restriction.value, "x_forwarded_for", null)
              x_forwarded_host  = lookup(ip_restriction.value, "x_forwarded_host", null)

            }


          }
          ip_address                = lookup(scm_ip_restriction.value, "ip_address", null)
          name                      = lookup(scm_ip_restriction.value, "name", null)
          priority                  = lookup(scm_ip_restriction.value, "priority", null)
          service_tag               = lookup(scm_ip_restriction.value, "service_tag", null)
          virtual_network_subnet_id = lookup(scm_ip_restriction.value, "virtual_network_subnet_id", null)
        }
        scm_minimum_tls_version     = lookup(local.site_config, "scm_minimum_tls_version", "1.2")
        scm_use_main_ip_restriction = lookup(local.site_config, "scm_use_main_ip_restriction", null)
        use_32_bit_worker           = lookup(local.site_config, "use_32_bit_worker", true)
        vnet_route_all_enabled      = lookup(local.site_config, "vnet_route_all_enabled", false)
        websockets_enabled          = lookup(local.site_config, "websockets_enabled", false)
        worker_count                = lookup(local.site_config, "worker_count", null)

      }









    }
    /*
A backup block supports the following:

name - (Required) The name which should be used for this Backup.

schedule - (Required) A schedule block as defined below.

storage_account_url - (Required) The SAS URL to the container.

enabled - (Optional) Should this backup job be enabled? Defaults to true.
*/

    dynamic "backup" {
      for_each = lookup(var.settings, "backup", {}) != {} ? [1] : []

      content {
        name                = var.settings.backup.name
        storage_account_url = var.settings.backup.storage_account_url
        enabled             = lookup(var.settings.backup, "enabled", true)

        dynamic "schedule" {
          for_each = try(var.settings.backup.schedule, {})

          content {
            frequency_interval       = lookup(schedule.value, "frequency_interval", null)
            frequency_unit           = lookup(schedule.value, "frequency_unit", null)
            keep_at_least_one_backup = lookup(schedule.value, "keep_at_least_one_backup", null)
            retention_period_in_days = lookup(schedule.value, "retention_period_in_days", null)
            start_time               = lookup(schedule.value, "start_time", null)
          }
        }
      }
    }

    # Create connection strings.
    dynamic "connection_string" {
      for_each = var.connection_strings

      content {
        name  = connection_string.value.name
        type  = connection_string.value.type
        value = connection_string.value.value
      }
    }

    dynamic "identity" {
      for_each = try(var.identity, null) == null ? [] : [1]

      content {
        type         = var.identity.type
        identity_ids = lower(var.identity.type) == "userassigned" ? local.managed_identities : null
      }
    }

    key_vault_reference_identity_id = can(var.settings.key_vault_reference_identity.key) ? var.combined_objects.managed_identities[try(var.settings.identity.lz_key, var.client_config.landingzone_key)][var.settings.key_vault_reference_identity.key].id : try(var.settings.key_vault_reference_identity.id, null)

    # Create a dynamic block for storage account
    dynamic "storage_account" {

      # Use the 'for_each' meta-argument to create an instance of the block for each item in a list or set of strings.
      # If 'var.settings.storage_account' is not an empty map, then create one instance. Otherwise, no instances are created.
      for_each = var.settings.storage_account != {} ? length(var.settings.storage_account) : []

      content {
        # The 'try' function is used to handle any errors that might occur when accessing 'var.settings.storage_account' properties.
        # If there is an error (meaning the property does not exist), 'null' is returned.

        # 'access_key' represents the access key for the storage account.
        access_key = var.settings.storage_account.access_key

        # 'account_name' represents the name of the storage account.
        account_name = var.settings.storage_account.account_name

        # 'name' represents the name to be used for this storage account.
        name = var.settings.storage_account.name

        # 'share_name' represents the name of the file share or container name for blob storage.
        share_name = var.settings.storage_account.share_name

        # 'type' represents the Azure Storage Type. Possible values include AzureFiles and AzureBlob.
        type = var.settings.storage_account.type

        # 'mount_path' represents the path at which to mount the storage share.
        mount_path = try(var.settings.storage_account.mount_path, null)
      }
    }

    # Create a variable to hold the list of app setting names that the Linux Function App will not swap between Slots when a swap operation is triggered.
    dynamic "sticky_settings" {
      # 'app_setting_names' - (Optional) A list of app_setting names that the Linux Function App will not swap between Slots when a swap operation is triggered.
      # 'connection_string_names' - (Optional) A list of connection_string names that the Linux Function App will not swap between Slots when a swap operation is triggered.
      for_each = lookup(var.settings, "sticky_settings", {}) != {} ? [1] : []
      content {
        app_setting_names       = lookup(var.settings.sticky_settings, "app_setting_names", null)
        connection_string_names = lookup(var.settings.sticky_settings, "connection_string_names", null)
      }
    }





    dynamic "source_control" {
      for_each = lookup(var.settings, "source_control", {}) != {} ? [1] : []

      content {
        repo_url           = var.settings.source_control.repo_url
        branch             = lookup(var.settings.source_control, "branch", null)
        manual_integration = lookup(var.settings.source_control, "manual_integration", null)
        rollback_enabled   = lookup(var.settings.source_control, "rollback_enabled", null)
        use_mercurial      = lookup(var.settings.source_control, "use_mercurial", null)
      }
    }
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "vnet_config" {
  depends_on     = [azurerm_linux_function_app.function_app]
  count          = lookup(var.settings, "subnet_key", null) == null && lookup(var.settings, "subnet_id", null) == null && var.settings.virtual_network_subnet_id == null ? 0 : 1
  app_service_id = azurerm_linux_function_app.function_app.id
  subnet_id = coalesce(
    try(var.remote_objects.subnets[var.settings.subnet_key].id, null),
    try(var.settings.subnet_id, null)
  )
}
