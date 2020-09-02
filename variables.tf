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

variable tfstates {}

# To support default values
variable convention {
  default = "cafrandom"
}

variable environment {
  default = "sandpit"
}

variable logged_user_objectId {
  description = "Used to set access policies based on the value 'logged_in_user'. Can only be used in interactive execution with vscode."
  default = null
}
variable logged_aad_app_objectId {
  description = "Used to set access policies based on the value 'logged_in_aad_app'"
  default = null
}

variable use_msi {
  default = false
}

variable tags {
  type    = map
  default = null
}

variable max_length {
  default = null
}

variable resource_groups {
  description = "Name of the existing resource group to deploy the virtual machine"
  default     = null
}

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
variable compute {
  description = "Compute object"
  default = {
    virtual_machines = {}
  }
}

variable app_service_environments {
  default = {}
}

variable app_service_plans {
  default = {}
}

variable app_services {
  default = {}
}

variable azurerm_application_insights {
  default = {}
}

## Databases variables
variable database {
  default = {}
}

## Networking variables
variable networking {
  default = {
    vnets                             = {}
    peerings                          = {}
    network_security_group_definition = {}
    firewalls                         = {}
  }
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
variable diagnostic_storage_accounts {
  default = {}
}

## Github
variable github {
  default = {
    github_secrets = {}
  }
}