module "front_doors" {
  source   = "./modules/networking/front_door"
  for_each = local.networking.front_doors

  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  base_tags           = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}

  client_config                 = local.client_config
  diagnostics                   = local.combined_diagnostics
  front_door_waf_policies       = local.combined_objects_front_door_waf_policies
  global_settings               = local.global_settings
  keyvault_id                   = can(each.value.keyvault_id) || can(each.value.keyvault_key) == false ? try(each.value.keyvault_id, null) : local.combined_objects_keyvaults[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.keyvault_key].id
  keyvault_certificate_requests = local.combined_objects_keyvault_certificate_requests
  settings                      = each.value
}

output "front_doors" {
  value = module.front_doors
}



# Register Azure FrontDoor service in the directory.
#
locals {
  front_door_application_id = "ad0e1c7e-6d38-4ba4-9efd-0bc77ba9f037"
}

# Execute the SP creation before from the AZ cli
# It will register the Azure FrontDoor global application ID with a service principal into your azure AD tenant
#   "az ad sp create --id ad0e1c7e-6d38-4ba4-9efd-0bc77ba9f037"

data "azuread_service_principal" "front_door" {
  for_each = {
    for key, value in local.networking.front_doors : key => value
    if try(value.keyvault_key, null) != null
  }
  application_id = local.front_door_application_id
}

module "front_doors_keyvault_access_policy" {
  source = "./modules/security/keyvault_access_policies"
  for_each = {
    for key, value in local.networking.front_doors : key => value
    if try(value.keyvault_key, null) != null
  }

  client_config = local.client_config
  keyvault_id   = local.combined_objects_keyvaults[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.keyvault_key].id

  access_policies = {
    front_door_certificate = {
      object_id               = data.azuread_service_principal.front_door[each.key].object_id
      certificate_permissions = ["Get"]
      secret_permissions      = ["Get"]
    }
  }
}

module "frontdoor_rules_engine" {
  source   = "./modules/networking/frontdoor_rules_engine"
  for_each = local.networking.frontdoor_rules_engine

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  frontdoor_name      = can(each.value.frontdoor.name) ? each.value.frontdoor.name : local.combined_objects_front_door[try(each.value.frontdoor.lz_key, local.client_config.landingzone_key)][each.value.frontdoor.key].name
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name

  remote_objects = {
    frontdoor      = local.combined_objects_front_door
    resource_group = local.combined_objects_resource_groups
  }
}
output "frontdoor_rules_engine" {
  value = module.frontdoor_rules_engine
}

module "frontdoor_custom_https_configuration" {
  source   = "./modules/networking/frontdoor_custom_https_configuration"
  for_each = local.networking.frontdoor_custom_https_configuration

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  remote_objects = {
    frontdoor      = local.combined_objects_front_door
    keyvault       = local.combined_objects_keyvaults
    resource_group = local.combined_objects_resource_groups
  }
}
output "frontdoor_custom_https_configuration" {
  value = module.frontdoor_custom_https_configuration
}