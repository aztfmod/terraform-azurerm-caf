# # Map of the remote data state for lower level
# variable lowerlevel_storage_account_name {}
# variable lowerlevel_container_name {}
# variable lowerlevel_key {} # Keeping the key for the lower level0 access
# variable lowerlevel_resource_group_name {}
# variable workspace {}

# Global settings 
variable global_settings {}



variable caf_foundations_security {
  default = {}
}


variable tags {
  type    = map
  default = {}
}

variable resource_groups {
  description = "Name of the existing resource group to deploy the virtual machine"
}

# variable default_region {
#   description = "Default region to deploy the resources"
#   default     = "region1"
# }

variable level {
  default = "level0"
  type    = string

  validation {
    condition     = contains(["level0", "level1", "level2", "level3", "level4"], var.level)
    error_message = "Allowed values are level0, level1, level2, level3 or level4."
  }
}

variable subscriptions {
  default = {}
}

## Accounting settings
variable diagnostics_definition {
  default     = {}
  description = "Shared diadgnostics settings that can be used by the services to enable diagnostics"
}

variable log_analytics {
  default = {}
}

variable accounting_settings {
  default = {}
}

variable caf_foundations_accounting {
  default = {}
}

## Azure AD
variable azuread_aad_apps {
  default = {}
}

variable azuread_aad_api_permissions {
  default = {}
}

## Compute variables
variable virtual_machines {
  description = "Virtual machine object"
  default     = {}
}

## Networking variables
variable networking {
  default = {}
}

variable network_security_group_definition {
  default = {}
}

variable vnets {
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

## Storage variables
variable storage_accounts {
  default = {}
}