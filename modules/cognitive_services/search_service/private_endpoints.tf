module "private_endpoint" {
  source   = "../../networking/private_endpoint"
  for_each = var.private_endpoints

  resource_id         = azurerm_search_service.search.id
  name                = each.value.name
  location            = var.location
  resource_group_name = var.resource_group
  subnet_id           = can(each.value.subnet_id) ? each.value.subnet_id : var.vnets[try(each.value.lz_key, var.client_config.landingzone_key)][each.value.vnet_key].subnets[each.value.subnet_key].id

  base_tags       = var.base_tags
  client_config   = var.client_config
  global_settings = var.global_settings
  private_dns     = var.private_dns
  settings        = each.value
  tags            = local.tags
}
