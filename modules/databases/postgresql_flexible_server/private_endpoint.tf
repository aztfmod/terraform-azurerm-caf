module "private_endpoint" {
  source   = "../../networking/private_endpoint"
  for_each = try(var.private_endpoints, {})

  resource_id         = azurerm_postgresql_flexible_server.postgresql.id
  name                = each.value.name
  location            = local.location
  resource_group_name = local.resource_group_name
  subnet_id           = can(each.value.subnet_id) ? each.value.subnet_id : var.vnets[try(each.value.lz_key, var.client_config.landingzone_key)][each.value.vnet_key].subnets[each.value.subnet_key].id
  settings            = each.value
  global_settings     = var.global_settings
  base_tags           = var.base_tags
  tags                = local.tags
  private_dns         = var.private_dns
  client_config       = var.client_config
}
