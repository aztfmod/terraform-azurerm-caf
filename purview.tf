module "purview_accounts" {
  source   = "./modules/purview/purview_accounts"
  for_each = local.purview.purview_accounts

  client_config   = local.client_config
  diagnostics     = local.combined_diagnostics
  global_settings = local.global_settings
  private_dns     = local.combined_objects_private_dns
  settings        = each.value

  base_tags           = local.global_settings.inherit_tags
  resource_group      = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : null
  location            = try(local.global_settings.regions[each.value.region], null)


  remote_objects = {
    vnets = local.combined_objects_networking
  }
}
output "purview_accounts" {
  value = module.purview_accounts
}