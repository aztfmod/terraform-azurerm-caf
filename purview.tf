module "purview_accounts" {
  source   = "./modules/purview/purview_accounts"
  for_each = local.purview.purview_accounts

  client_config   = local.client_config
  diagnostics     = local.combined_diagnostics
  global_settings = local.global_settings
  private_dns     = local.combined_objects_private_dns
  settings        = each.value
  resource_group  = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)]
  base_tags       = local.global_settings.inherit_tags

  remote_objects = {
    vnets = local.combined_objects_networking
  }
}
output "purview_accounts" {
  value = module.purview_accounts
}