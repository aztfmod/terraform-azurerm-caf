module "private_endpoint" {
  source = "../../../networking/private_endpoint"
  #for_each = try(var.settings.private_endpoints, {})
  for_each = lookup(var.settings, "private_endpoints", {})

  base_tags           = var.base_tags
  tags                = local.tags
  client_config       = var.client_config
  global_settings     = var.global_settings
  location            = local.location
  name                = each.value.name
  private_dns         = can(each.value.private_dns) ? var.remote_objects.private_dns : {}
  resource_group_name = local.resource_group_name
  resource_id         = azurerm_servicebus_namespace.namespace.id
  settings            = each.value
  subnet_id           = can(each.value.subnet_id) ? each.value.subnet_id : var.remote_objects.vnets[try(each.value.lz_key, var.client_config.landingzone_key)][each.value.vnet_key].subnets[each.value.subnet_key].id
}
