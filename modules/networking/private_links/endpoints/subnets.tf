module subnet {
  source = "./subnet"
  for_each = {
    for key, value in try(var.settings.subnets, {}) : key => value
    if try(value.private_endpoints_key, null) != null
  }

  global_settings          = var.global_settings
  client_config            = var.client_config
  resource_groups          = var.resource_groups
  private_endpoints        = var.private_endpoints[each.value.private_endpoints_key]
  vnet_resource_group_name = var.vnet.resource_group_name
  vnet_location            = var.vnet.location
  subnet_id                = var.vnet.subnets[each.key].id
  remote_objects           = var.remote_objects
  base_tags                = var.base_tags
}