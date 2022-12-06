# Global settings
variable "global_settings" {
  type        = any
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
  type    = any
  default = {}
}

## Cloud variables
variable "cloud" {
  type        = any
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
  type        = string
  description = "Azure AD Tenant ID for the current deployment."
  default     = null
}

variable "current_landingzone_key" {
  description = "Key for the current landing zones where the deployment is executed. Used in the context of landing zone deployment."
  default     = "local"
  type        = string
}

variable "tfstates" {
  type        = any
  description = "Terraform states configuration object. Used in the context of landing zone deployment."
  default     = {}
}

variable "enable" {
  type        = any
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
  type        = any
  description = "Tags to be used for this resource deployment."
  default     = null
}

variable "resource_groups" {
  type        = any
  description = "Configuration object - Resource groups."
  default     = {}
}

variable "subscriptions" {
  type        = any
  description = "Configuration object - Subscriptions resources."
  default     = {}
}

variable "connectivity_subscription_id" {
  type        = any
  description = "Connectivity subscription id"
  default     = null
}

variable "connectivity_tenant_id" {
  type        = any
  description = "Connectivity tenant id"
  default     = null
}

variable "subscription_billing_role_assignments" {
  type        = any
  description = "Configuration object - subscription billing roleassignments."
  default     = {}
}

variable "billing" {
  type        = any
  description = "Configuration object - Billing information."
  default     = {}
}

variable "remote_objects" {
  type        = any
  description = "Allow the landing zone to retrieve remote tfstate objects and pass them to the CAF module."
  default     = {}
}

## Diagnostics settings
variable "diagnostics_definition" {
  type        = any
  default     = null
  description = "Configuration object - Shared diadgnostics settings that can be used by the services to enable diagnostics."
}

variable "diagnostics_destinations" {
  type        = any
  description = "Configuration object - Describes the destinations for the diagnostics."
  default     = null
}

variable "log_analytics" {
  type        = any
  description = "Configuration object - Log Analytics resources."
  default     = {}
}

variable "diagnostics" {
  type        = any
  description = "Configuration object - Diagnostics object."
  default     = {}
}

variable "event_hub_namespaces" {
  type        = any
  description = "Configuration object - Diagnostics object."
  default     = {}
}

# variable "subnet_id" {
#  type = string
#   default = {}
# }

variable "user_type" {
  type        = any
  description = "The rover set this value to user or serviceprincipal. It is used to handle Azure AD API consents."
  default     = {}
}

## Azure AD
variable "azuread" {
  type        = any
  description = "Configuration object - Azure Active Directory resources"
  default     = {}
}

# variable "azuread_api_permissions" {
#  type = any
#   default = {}
# }

## Compute variables
variable "compute" {
  type        = any
  description = "Configuration object - Azure compute resources"
  default = {
    virtual_machines = {}
  }
}

variable "webapp" {
  type        = any
  description = "Configuration object - Web Applications"
  default = {
    # app_services                 = {}
    # app_service_environments     = {}
    # app_service_plans            = {}
    # azurerm_application_insights = {}
  }
}

variable "data_factory" {
  type        = any
  description = "Configuration object - Azure Data Factory resources"
  default     = {}
}

variable "logic_app" {
  type        = any
  description = "Configuration object - Azure Logic App resources"
  default     = {}
}

## Databases variables
variable "database" {
  type        = any
  description = "Configuration object - databases resources"
  default     = {}
}

variable "messaging" {
  type        = any
  description = "Configuration object - messaging resources"
  default     = {}
}

## DataProtection variables
variable "data_protection" {
  type        = any
  description = "Configuration object - data protection"
  default     = {}
}

## Networking variables
variable "networking" {
  type        = any
  description = "Configuration object - networking resources"
  default     = {}
}

## Security variables
variable "security" {
  type        = any
  description = "Configuration object - security resources"
  default     = {}
}

variable "managed_identities" {
  type        = any
  description = "Configuration object - Azure managed identity resources"
  default     = {}
}

variable "keyvaults" {
  type        = any
  description = "Configuration object - Azure Key Vault resources"
  default     = {}
}

variable "keyvault_access_policies" {
  type        = any
  description = "Configuration object - Azure Key Vault policies"
  default     = {}
}

variable "keyvault_access_policies_azuread_apps" {
  type        = any
  description = "Configuration object - Azure Key Vault policy for azure ad applications"
  default     = {}
}

variable "custom_role_definitions" {
  type        = any
  description = "Configuration object - Custom role definitions"
  default     = {}
}

variable "role_mapping" {
  type        = any
  description = "Configuration object - Role mapping"
  default = {
    built_in_role_mapping = {}
    custom_role_mapping   = {}
  }
}

variable "dynamic_keyvault_secrets" {
  type    = any
  default = {}
}

## Storage variables
variable "storage_accounts" {
  type        = any
  description = "Configuration object - Storage account resources"
  default     = {}
}
variable "storage" {
  type        = any
  description = "Configuration object - Storage account resources"
  default     = {}
}
variable "diagnostic_storage_accounts" {
  type        = any
  description = "Configuration object - Storage account for diagnostics resources"
  default     = {}
}

# Shared services
variable "shared_services" {
  type        = any
  description = "Configuration object - Shared services resources"
  default = {
    # automations = {}
    # monitoring = {}
    # recovery_vaults = {}
  }
}

variable "var_folder_path" {
  type    = string
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
#  type = any
#   default = {}
# }

# variable "packer_service_principal" {
#   default = {}
# }

# variable "packer_managed_identity" {
#   default = {}
# }

variable "keyvault_certificate_issuers" {
  type        = any
  description = "Configuration object - Azure Key Vault Certificate Issuers resources"
  default     = {}
}
# variable "cosmos_dbs" {
#   default = {}
# }

variable "app_config" {
  type    = any
  default = {}
}

# variable "local_network_gateways" {
#   default = {}
# }

# variable "application_security_groups" {
#type = any
#   default = {}
# }
variable "event_hubs" {
  type        = any
  description = "Configuration object - Event Hub resources"
  default     = {}
}

variable "event_hub_auth_rules" {
  type        = any
  description = "Configuration object - Event Hub authentication rules"
  default     = {}
}

variable "event_hub_namespace_auth_rules" {
  type        = any
  description = "Configuration object - Event Hub namespaces authentication rules"
  default     = {}
}

variable "event_hub_consumer_groups" {
  type        = any
  description = "Configuration object - Event Hub consumer group rules"
  default     = {}
}

variable "random_strings" {
  type        = any
  description = "Configuration object - Random string generator resources"
  default     = {}
}

variable "cognitive_services" {
  type        = any
  description = "Configuration object - Cognitive Service Resource "
  default     = {}
}

variable "communication" {
  type        = any
  description = "Configuration object - communication resources"
  default     = {}
}

variable "identity" {
  type        = any
  description = "Configuration object - identity resources"
  default     = {}
}
variable "apim" {
  type    = any
  default = {}
}
variable "purview" {
  type    = any
  default = {}
}
variable "sentinel_watchlists" {
  type    = any
  default = {}
}
variable "iot" {
  type        = any
  description = "Configuration object - IoT"
  default = {
    # digital_twins_instances                 = {}
    # digital_twins_endpoint_eventhubs                 = {}
    # digital_twins_endpoint_eventgrids = {}
    # digital_twins_endpoint_servicebuses = {}

  }
}
variable "resource_provider_registration" {
  type    = any
  default = {}
}
