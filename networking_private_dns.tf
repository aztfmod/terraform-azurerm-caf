

module "private_dns" {
  source   = "./modules/networking/private-dns"
  for_each = local.networking.private_dns

  global_settings     = local.global_settings
  client_config       = local.client_config
  name                = each.value.name
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  records             = try(each.value.records, {})
  vnet_links          = try(each.value.vnet_links, {})
  tags                = try(each.value.tags, null)
  vnets               = local.combined_objects_networking
  base_tags           = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}
}

output "private_dns" {
  value = module.private_dns
}

#
# Create vnet links on remote DNS zones
#

module "private_dns_vnet_link" {
  source   = "./modules/networking/private_dns_vnet_link"
  for_each = try(local.networking.private_dns_vnet_link, {})
  depends  = [module.private_dns]

  base_tags          = {}
  global_settings    = local.global_settings
  client_config      = local.client_config
  virtual_network_id = local.combined_objects_networking[local.client_config.landingzone_key][each.value.vnet_key].id
  private_dns        = local.combined_objects_private_dns
  settings           = each.value
}

output "private_dns_vnet_link" {
  value = module.private_dns_vnet_link
}