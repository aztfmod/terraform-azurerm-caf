module "maps_accounts" {
  source   = "./modules/maps/maps_account"
  for_each = var.maps.maps_accounts

  global_settings     = local.global_settings
  base_tags           = local.global_settings.inherit_tags
  resource_group      = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : null
  sku_name            = try(each.value.sku_name,"S0")
  settings            = each.value
  remote_objects = {
    keyvault_id         = can(each.value.keyvault.key) ? local.combined_objects_keyvaults[try(each.value.keyvault.lz_key, local.client_config.landingzone_key)][each.value.keyvault.key].id : null
  }
}

output "maps_accounts" {
  value     = module.maps_accounts
}