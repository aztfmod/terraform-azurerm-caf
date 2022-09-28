module "private_endpoint" {
  source   = "../../networking/private_endpoint"
  for_each = try(var.private_endpoints, {})

  resource_id         = azurerm_mysql_server.mysql.id
  name                = each.value.name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = can(each.value.subnet_id) ? each.value.subnet_id : try(var.vnets[try(each.value.lz_key, var.client_config.landingzone_key)][each.value.vnet_key].subnets[each.value.subnet_key].id, var.virtual_subnets[try(each.value.lz_key, var.client_config.landingzone_key)][each.value.subnet_key].id)
  settings            = each.value
  global_settings     = var.global_settings
  base_tags           = local.tags
  private_dns         = var.private_dns
  client_config       = var.client_config
}
