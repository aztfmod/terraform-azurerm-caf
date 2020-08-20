# Global settings 
variable global_settings {
  default = {
    prefix         = ""
    convention     = "cafrandom"
    max_length     = 40
    default_region = "region1"
    regions = {
      region1 = "southeastasia"
    }
  }
}

# To support default values
variable convention {
  default = "cafrandom"
}

variable environment {
  default = "sandpit"
}

variable max_length {
  default = "40"
}


variable logged_user_objectId {
  default = null
}

# variable caf_foundations_security {
#   default = null
# }


variable tags {
  type    = map
  default = null
}

variable resource_groups {
  description = "Name of the existing resource group to deploy the virtual machine"
  default     = null
}

# variable level {
#   default = "level0"
#   type    = string

#   validation {
#     condition     = contains(["level0", "level1", "level2", "level3", "level4"], var.level)
#     error_message = "Allowed values are level0, level1, level2, level3 or level4."
#   }
# }

variable subscriptions {
  default = {}
}

## Diagnostics settings
variable diagnostics_definition {
  default     = null
  description = "Shared diadgnostics settings that can be used by the services to enable diagnostics"
}

variable diagnostics_destinations {
  default = null
}

variable log_analytics {
  default = {}
}

variable diagnostics {
  default = {}
}

variable caf_foundations_accounting {
  default = {}
}

variable user_type {
  description = "The rover set this value to user or serviceprincipal. It is used to handle Azure AD api consents."
  default     = {}
}

## Azure AD
variable azuread_apps {
  default = {}
}

variable azuread_groups {
  default = {}
}

variable azuread_app_roles {
  default = {}
}

variable azuread_users {
  default = {}
}

variable azuread_api_permissions {
  default = {}
}

## Compute variables
variable virtual_machines {
  description = "Virtual machine object"
  default     = {}
}

variable app_service_environments {
  default = {}
}

variable app_service_plans {
  default = {}
}

variable azurerm_application_insights {
  default = {}
}

## Networking variables
variable networking {
  default = {}
}

variable network_security_group_definition {
  default = {}
}

variable networking_objects {
  description = "Represent an already deployed vnet output by another landingzone"
  default     = {}
}

variable firewalls {
  default = {}
}

## Security variables
variable managed_identities {
  default = {}
}

variable keyvaults {
  default = {}
}

variable keyvault_access_policies {
  default = {}
}

variable custom_role_definitions {
  default = {}
}
variable role_mapping {
  default = {
    built_in_role_mapping = {}
    custom_role_mapping   = {}
  }
}

## Storage variables
variable storage_accounts {
  default = {}
}