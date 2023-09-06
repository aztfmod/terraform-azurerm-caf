module "azuread_administrative_unit" {
  source   = "./modules/azuread/administrative_unit"
  for_each = local.azuread.azuread_administrative_units

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
}
output "azuread_administrative_unit" {
  value = module.azuread_administrative_unit
}

module "azuread_administrative_unit_member" {
  source   = "./modules/azuread/administrative_unit_member"
  for_each = local.azuread.azuread_administrative_unit_members

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  remote_objects = {
    azuread_administrative_units = local.combined_objects_azuread_administrative_units
    azuread_groups               = local.combined_objects_azuread_groups
    azuread_users                = local.combined_objects_azuread_users
  }
}
output "azuread_administrative_unit_member" {
  value = module.azuread_administrative_unit_member
}