variable launchpad_mode {
  default = "launchpad_light"
  type    = string

  validation {
    condition     = contains(["launchpad_light", "launchpad"], var.launchpad_mode)
    error_message = "Allowed values are launchpad_light or launchpad."
  }
}

variable level {
  default = "level0"
  type    = string

  validation {
    condition     = contains(["level0", "level1", "level2", "level3", "level4"], var.level)
    error_message = "Allowed values are level0, level1, level2, level3 or level4."
  }
}

variable convention {
  default = "cafrandom"

  validation {
    condition     = contains(["cafrandom", "random", "passthrough", "cafclassic"], var.convention)
    error_message = "Convention allowed values are cafrandom, random, passthrough or cafclassic."
  }
}

variable default_region {
  description = "Define the default region where services are deployed if the location is not set at the resource level"
  default     = "region1"
}

variable regions {
  description = "List of the regions where services can be deployed. This impact the diagnostics logs settings"
  default = {
    region1 = "southeastasia"
  }
}
variable max_length {
  description = "Define the max length the naming convention will apply to generated name"
  default     = 0
}

variable prefix {
  default = null
}

variable log_analytics {
  default = {}
}

variable accounting_settings {
  default = {}
}

# Do not change the default value to be able to upgrade to the standard launchpad
variable tf_name {
  description = "Name of the terraform state in the blob storage (Does not include the extension .tfstate)"
  default     = "launchpad"
}

variable resource_groups {}

variable storage_accounts {}

variable keyvaults {}
variable keyvault_access_policies {}

variable subscriptions {}

## Azure Active Directory
variable azuread_apps {
  default = {}
}
variable azuread_groups {
  default = {}
}
variable azuread_users {
  default = {}
}
variable azuread_roles {
  default = {}
}


variable launchpad_key_names {}

variable custom_role_definitions {
  default = {}
}

variable tags {
  type    = map
  default = {}
}

variable rover_version {}

variable user_type {}

variable logged_user_objectId {}

variable aad_users {
  default = {}
}

variable aad_roles {
  default = {}
}

variable aad_api_permissions {
  default = {}
}

variable github_projects {
  default = {}
}

variable azure_devops {
  default = {}
}

variable environment {
  type        = string
  description = "This variable is set by the rover during the deployment based on the -env or -environment flags. Default to sandpit"
}

variable blueprint_networking {
  default = {}
}

variable diagnostics_definition {
  default = {}
}
variable diagnostics_destinations {
  default = {}
}

variable networking {
  default = {}
}

variable network_security_group_definition {
  default = {}
}
