module "private_endpoint" {
  source   = "../../networking/private_endpoint"
  for_each = try(var.settings.private_endpoints, {})

  tags            = local.tags
  base_tags       = var.base_tags
  client_config   = var.client_config
  global_settings = var.global_settings
  location        = local.location
  name            = each.value.name
  private_dns     = var.remote_objects.private_dns
  resource_groups = var.remote_objects.resource_groups
  resource_id     = azurerm_web_pubsub.wps.id
  settings        = each.value
  subnet_id       = can(each.value.subnet_id) ? each.value.subnet_id : var.remote_objects.vnets[try(each.value.lz_key, var.client_config.landingzone_key)][each.value.vnet_key].subnets[each.value.subnet_key].id
}
