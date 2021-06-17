
module "managed_identities" {
  source   = "./modules/security/managed_identity"
  for_each = var.managed_identities

  name                = each.value.name
  resource_group_name = local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.resource_group_key].name
  location            = local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.resource_group_key].location
  global_settings     = local.global_settings
  settings            = each.value
  base_tags           = try(local.global_settings.inherit_tags, false) ? local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.resource_group_key].tags : {}
}

output "managed_identities" {
  value = module.managed_identities

}
