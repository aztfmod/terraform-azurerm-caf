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
  description = "Configuration object - Cloud resources defaults to Azure, allows you to switch to Azure sovereign endpoints."
  default     = {}
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
  default = {}
}

variable "subscription_billing_role_assignments" {
  description = "Configuration object - subscription billing roleassignments."
  default = {}
}

variable "billing" {
  description = "Configuration object - Billing information."
  default     = {}
}

variable "remote_objects" {
  description = "Allow the landing zone to retrieve remote tfstate objects and pass them to the CAF module."
  default     = {}
}

## Diagnostics settings
variable "diagnostics_definition" {
  default     = null
  description = "Configuration object - Shared diadgnostics settings that can be used by the services to enable diagnostics."
}

variable "diagnostics_destinations" {
  description = "Configuration object - Describes the destinations for the diagnostics."
  default = null
}

variable "log_analytics" {
  description = "Configuration object - Log Analytics resources."
  default = {}
}

variable "diagnostics" {
  description = "Configuration object - Diagnostics object."
  default = {}
}

variable "event_hub_namespaces" {
  description = "Configuration object - Diagnostics object."
  default = {}
}

# variable "subnet_id" {
#   default = {}
# }

variable "user_type" {
  description = "The rover set this value to user or serviceprincipal. It is used to handle Azure AD API consents."
  default     = {}
}

## Azure AD
variable "azuread" {
  description = "Configuration object - Azure Active Directory resources"
  default = {}
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
  default = {}
}

variable "logic_app" {
  description = "Configuration object - Azure Logic App resources"
  default = {}
}

## Databases variables
variable "database" {
  description = "Configuration object - databases resources"
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
  default = {}
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
  default = {}
}

variable "keyvault_access_policies_azuread_apps" {
  description = "Configuration object - Azure Key Vault policy for azure ad applications"
  default = {}
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
  default = {}
}
variable "storage" {
  description = "Configuration object - Storage account resources"
  default     = {}
}
variable "diagnostic_storage_accounts" {
  description = "Configuration object - Storage account for diagnostics resources"
  default = {}
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
  default = {}
}
# variable "cosmos_dbs" {
#   default = {}
# }

# variable "app_config" {
#   default = {}
# }

# variable "local_network_gateways" {
#   default = {}
# }

# variable "application_security_groups" {
#   default = {}
# }
variable "event_hubs" {
  description = "Configuration object - Event Hub resources"
  default = {}
}

variable "event_hub_auth_rules" {
  description = "Configuration object - Event Hub authentication rules"
  default = {}
}

variable "event_hub_namespace_auth_rules" {
  description = "Configuration object - Event Hub namespaces authentication rules"
  default = {}
}

variable "event_hub_consumer_groups" {
  description = "Configuration object - Event Hub consumer group rules"
  default = {}
}

variable "random_strings" {
  description = "Configuration object - Random string generator resources"
  default = {}
}
