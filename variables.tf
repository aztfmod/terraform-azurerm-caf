# Global settings
variable "global_settings" {
  description = "Global settings object for the current deployment."
  default = {
    passthrough    = false
    random_length  = 4
    default_region = "region1"
    regions = {
      region1 = "southeastasia"
      region2 = "eastasia"
    }
  }
}

variable "client_config" {
  default = {}
}

## Cloud variables
variable "cloud" {
  description = "Configuration object - Cloud resources defaults to Azure public, allows you to switch to other Azure endpoints."
  default = {
    acrLoginServerEndpoint                      = ".azurecr.io"
    attestationEndpoint                         = ".attest.azure.net"
    azureDatalakeAnalyticsCatalogAndJobEndpoint = "azuredatalakeanalytics.net"
    azureDatalakeStoreFileSystemEndpoint        = "azuredatalakestore.net"
    keyvaultDns                                 = ".vault.azure.net"
    mariadbServerEndpoint                       = ".mariadb.database.azure.com"
    mhsmDns                                     = ".managedhsm.azure.net"
    mysqlServerEndpoint                         = ".mysql.database.azure.com"
    postgresqlServerEndpoint                    = ".postgres.database.azure.com"
    sqlServerHostname                           = ".database.windows.net"
    storageEndpoint                             = "core.windows.net"
    storageSyncEndpoint                         = "afs.azure.net"
    synapseAnalyticsEndpoint                    = ".dev.azuresynapse.net"
    activeDirectory                             = "https://login.microsoftonline.com"
    activeDirectoryDataLakeResourceId           = "https://datalake.azure.net/"
    activeDirectoryGraphResourceId              = "https://graph.windows.net/"
    activeDirectoryResourceId                   = "https://management.core.windows.net/"
    appInsightsResourceId                       = "https://api.applicationinsights.io"
    appInsightsTelemetryChannelResourceId       = "https://dc.applicationinsights.azure.com/v2/track"
    attestationResourceId                       = "https://attest.azure.net"
    azmirrorStorageAccountResourceId            = "null"
    batchResourceId                             = "https://batch.core.windows.net/"
    gallery                                     = "https://gallery.azure.com/"
    logAnalyticsResourceId                      = "https://api.loganalytics.io"
    management                                  = "https://management.core.windows.net/"
    mediaResourceId                             = "https://rest.media.azure.net"
    microsoftGraphResourceId                    = "https://graph.microsoft.com/"
    ossrdbmsResourceId                          = "https://ossrdbms-aad.database.windows.net"
    portal                                      = "https://portal.azure.com"
    resourceManager                             = "https://management.azure.com/"
    sqlManagement                               = "https://management.core.windows.net:8443/"
    synapseAnalyticsResourceId                  = "https://dev.azuresynapse.net"
    vmImageAliasDoc                             = "https://raw.githubusercontent.com/Azure/azure-rest-api-specs/master/arm-compute/quickstart-templates/aliases.json"
  }
}

variable "tenant_id" {
  description = "Azure AD Tenant ID for the current deployment."
  type        = string
  default     = null
}

variable "current_landingzone_key" {
  description = "Key for the current landing zones where the deployment is executed. Used in the context of landing zone deployment."
  default     = "local"
  type        = string
}

variable "tfstates" {
  description = "Terraform states configuration object. Used in the context of landing zone deployment."
  default     = {}
}

variable "enable" {
  description = "Map of services defined in the configuration file you want to disable during a deployment."
  default = {
    # bastion_hosts    = true
    # virtual_machines = true
  }
}

variable "environment" {
  description = "Name of the CAF environment."
  type        = string
  default     = "sandpit"
}

variable "logged_user_objectId" {
  description = "Used to set access policies based on the value 'logged_in_user'. Can only be used in interactive execution with vscode."
  type        = string
  default     = null
}
variable "logged_aad_app_objectId" {
  description = "Used to set access policies based on the value 'logged_in_aad_app'"
  type        = string
  default     = null
}

variable "use_msi" {
  description = "Deployment using an MSI for authentication."
  default     = false
  type        = bool
}

variable "tags" {
  description = "Tags to be used for this resource deployment."
  type        = map(any)
  default     = null
}

variable "resource_groups" {
  description = "Configuration object - Resource groups."
  default     = {}
}

variable "subscriptions" {
  description = "Configuration object - Subscriptions resources."
  default     = {}
}

variable "connectivity_subscription_id" {
  description = "Connectivity subscription id"
  default     = null
}

variable "connectivity_tenant_id" {
  description = "Connectivity tenant id"
  default     = null
}

variable "subscription_billing_role_assignments" {
  description = "Configuration object - subscription billing roleassignments."
  default     = {}
}

variable "billing" {
  description = "Configuration object - Billing information."
  default     = {}
}

variable "remote_objects" {
  description = "Allow the landing zone to retrieve remote tfstate objects and pass them to the CAF module."
  default     = {}
}

variable "data_sources" {
  description = "Data gathering for resources not managed by CAF Module"
  default     = {}
}

## Diagnostics settings
variable "diagnostics_definition" {
  default     = null
  description = "Configuration object - Shared diadgnostics settings that can be used by the services to enable diagnostics."
}

variable "diagnostics_destinations" {
  description = "Configuration object - Describes the destinations for the diagnostics."
  default     = null
}

variable "log_analytics" {
  description = "Configuration object - Log Analytics resources."
  default     = {}
}

variable "diagnostics" {
  description = "Configuration object - Diagnostics object."
  default     = {}
}

variable "event_hub_namespaces" {
  description = "Configuration object - Diagnostics object."
  default     = {}
}

# variable "subnet_id" {
#   default = {}
# }

variable "user_type" {
  description = "The rover set this value to user or serviceprincipal. It is used to handle Azure AD API consents."
  default     = {}
}

## Azure Maps
variable "maps" {
  description = "Configuration object - Azure map "
  default     = {}
}
## Azure AD
variable "azuread" {
  description = "Configuration object - Azure Active Directory resources"
  default     = {}
}

# variable "azuread_api_permissions" {
#   default = {}
# }

## Compute variables
variable "compute" {
  description = "Configuration object - Azure compute resources"
  default = {
    virtual_machines = {}
  }
}

variable "webapp" {
  description = "Configuration object - Web Applications"
  default = {
    # app_services                 = {}
    # app_service_environments     = {}
    # app_service_plans            = {}
    # azurerm_application_insights = {}
  }
}

variable "data_factory" {
  description = "Configuration object - Azure Data Factory resources"
  default     = {}
}

variable "logic_app" {
  description = "Configuration object - Azure Logic App resources"
  default     = {}
}

## Databases variables
variable "database" {
  description = "Configuration object - databases resources"
  default     = {}
}

variable "messaging" {
  description = "Configuration object - messaging resources"
  default     = {}
}

## DataProtection variables
variable "data_protection" {
  description = "Configuration object - data protection"
  default     = {}
}

## Networking variables
variable "networking" {
  description = "Configuration object - networking resources"
  default     = {}
}

## Security variables
variable "security" {
  description = "Configuration object - security resources"
  default     = {}
}

variable "managed_identities" {
  description = "Configuration object - Azure managed identity resources"
  default     = {}
}

variable "keyvaults" {
  description = "Configuration object - Azure Key Vault resources"
  default     = {}
}

variable "keyvault_access_policies" {
  description = "Configuration object - Azure Key Vault policies"
  default     = {}
}

variable "keyvault_access_policies_azuread_apps" {
  description = "Configuration object - Azure Key Vault policy for azure ad applications"
  default     = {}
}

variable "custom_role_definitions" {
  description = "Configuration object - Custom role definitions"
  default     = {}
}

variable "role_mapping" {
  description = "Configuration object - Role mapping"
  default = {
    built_in_role_mapping = {}
    custom_role_mapping   = {}
  }
}

variable "dynamic_keyvault_secrets" {
  default = {}
}

## Storage variables
variable "storage_accounts" {
  description = "Configuration object - Storage account resources"
  default     = {}
}
variable "storage" {
  description = "Configuration object - Storage account resources"
  default     = {}
}
variable "diagnostic_storage_accounts" {
  description = "Configuration object - Storage account for diagnostics resources"
  default     = {}
}

# Shared services
variable "shared_services" {
  description = "Configuration object - Shared services resources"
  default = {
    # automations = {}
    # monitoring = {}
    # recovery_vaults = {}
  }
}

variable "var_folder_path" {
  default = ""
}

# variable "virtual_network_gateways" {
#   default = {}
# }

# variable "virtual_network_gateway_connections" {
#   default = {}
# }

# variable "shared_image_galleries" {
#   default = {}
# }

# variable "image_definitions" {
#   default = {}
# }

# variable "packer_service_principal" {
#   default = {}
# }

# variable "packer_managed_identity" {
#   default = {}
# }

variable "keyvault_certificate_issuers" {
  description = "Configuration object - Azure Key Vault Certificate Issuers resources"
  default     = {}
}
# variable "cosmos_dbs" {
#   default = {}
# }

variable "app_config" {
  default = {}
}

# variable "local_network_gateways" {
#   default = {}
# }

# variable "application_security_groups" {
#   default = {}
# }
variable "event_hubs" {
  description = "Configuration object - Event Hub resources"
  default     = {}
}

variable "event_hub_auth_rules" {
  description = "Configuration object - Event Hub authentication rules"
  default     = {}
}

variable "event_hub_namespace_auth_rules" {
  description = "Configuration object - Event Hub namespaces authentication rules"
  default     = {}
}

variable "event_hub_consumer_groups" {
  description = "Configuration object - Event Hub consumer group rules"
  default     = {}
}

variable "random_strings" {
  description = "Configuration object - Random string generator resources"
  default     = {}
}

variable "cognitive_services" {
  description = "Configuration object - Cognitive Service Resource "
  default     = {}
}

variable "communication" {
  description = "Configuration object - communication resources"
  default     = {}
}

variable "identity" {
  description = "Configuration object - identity resources"
  default     = {}
}
variable "apim" {
  default = {}
}

variable "purview" {
  default = {}
}

variable "sentinel_watchlists" {
  default = {}
}
variable "iot" {
  description = "Configuration object - IoT"
  default = {
    # digital_twins_instances                 = {}
    # digital_twins_endpoint_eventhubs                 = {}
    # digital_twins_endpoint_eventgrids = {}
    # digital_twins_endpoint_servicebuses = {}

  }
}
variable "resource_provider_registration" {
  default = {}
}
variable "aadb2c" {
  description = "Configuration object - AAD B2C resources"
  default     = {}
}
variable "preview_features" {
  default = {}
}
variable "powerbi_embedded" {
  default = {}
}
variable "maintenance" {
  default = {}
}
variable "search_services" {
  description = "Configuration object - Search service Resource "
  default     = {}
}
variable "load_test" {
  description = "Configuration object - Load Test resources"
  default     = {}
}

