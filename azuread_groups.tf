
#
# Azure Active Directory Groups
#

module "azuread_groups" {
  source   = "./modules/azuread/groups"
  for_each = local.azuread.azuread_groups

  global_settings = local.global_settings
  azuread_groups  = each.value
  tenant_id       = local.client_config.tenant_id
  client_config   = local.client_config
  remote_objects = {
    azuread_administrative_units = local.combined_objects_azuread_administrative_units
  }
}

output "azuread_groups" {
  value = module.azuread_groups

}

module "azuread_groups_members" {
  source   = "./modules/azuread/groups_members"
  for_each = local.azuread.azuread_groups

  client_config              = local.client_config
  settings                   = each.value
  azuread_groups             = module.azuread_groups
  group_id                   = module.azuread_groups[each.key].object_id
  azuread_apps               = module.azuread_applications
  azuread_service_principals = local.combined_objects_azuread_service_principals[try(each.value.lz_key, local.client_config.landingzone_key)]
}

# Module to decouple AD Group membership to remote AD Groups
module "azuread_groups_membership" {
  source   = "./modules/azuread/groups_members"
  for_each = local.azuread.azuread_groups_membership

  client_config              = local.client_config
  group_key                  = try(each.value.key, each.key) # Make it possible to have orphen name of top level keys, useful when you have group keys with same name in different LZs
  settings                   = each.value
  group_id                   = local.combined_objects_azuread_groups[try(each.value.group_lz_key, local.client_config.landingzone_key)][each.key].id
  azuread_groups             = local.combined_objects_azuread_groups
  azuread_service_principals = local.combined_objects_azuread_service_principals
  managed_identities         = local.combined_objects_managed_identities
  mssql_servers              = local.combined_objects_mssql_servers
}
