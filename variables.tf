# Global settings
variable global_settings {
  default = {
    passthrough    = false
    random_length  = 4
    default_region = "region1"
    regions = {
      region1 = "southeastasia"
    }
  }
}

variable tenant_id {
  default = null
}

variable current_landingzone_key {
  default = "standalone"
}

variable tfstates {
  default = {}
}

variable enable {
  description = "Map of services defined in the configuration file you want to disable during a deployment"
  default     = {}
}
variable environment {
  default = "sandpit"
}

variable logged_user_objectId {
  description = "Used to set access policies based on the value 'logged_in_user'. Can only be used in interactive execution with vscode."
  default     = null
}
variable logged_aad_app_objectId {
  description = "Used to set access policies based on the value 'logged_in_aad_app'"
  default     = null
}

variable use_msi {
  default = false
}

variable tags {
  type    = map
  default = null
}

variable resource_groups {
  description = "Name of the existing resource group to deploy the virtual machine"
  default     = {}
}

variable subscriptions {
  default = {}
}

variable remote_objects {
  description = "Remote objects is used to allow the landing zone to retrieve remote tfstate objects and pass them to the caf module"
  default     = {}
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

variable event_hub_namespaces {
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

variable azuread_roles {
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

variable webapp {
  default = {}
}

## Databases variables
variable database {
  default = {}
}

## Networking variables
variable networking {
  default = {}
}

## Security variables
variable security {
  default = {}
}

variable managed_identities {
  default = {}
}

variable keyvaults {
  default = {}
}

variable keyvault_access_policies {
  default = {}
}

variable keyvault_access_policies_azuread_apps {
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
variable storage {
  default = {}
}
variable diagnostic_storage_accounts {
  default = {}
}

# Shared services
variable shared_services {
  default = {}
}

variable monitoring {
  default = {}
}



