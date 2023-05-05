module "private_endpoint" {
  source   = "../../networking/private_endpoint"
  for_each = var.private_endpoints

  resource_id         = azurerm_monitor_private_link_scope.mpls.id
  name                = each.value.name
  location            = var.resource_groups[try(each.value.resource_group.lz_key, var.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name = var.resource_groups[try(each.value.resource_group.lz_key, var.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].name
  subnet_id           = can(each.value.subnet_id) ? each.value.subnet_id : coalesce(
    try(var.vnets[try(each.value.lz_key, var.client_config.landingzone_key)][each.value.vnet_key].subnets[each.value.subnet_key].id, null),
    try(var.virtual_subnets[try(each.value.lz_key, var.client_config.landingzone_key)][each.value.subnet_key].id, null)
  )

  settings        = each.value
  global_settings = var.global_settings
  base_tags       = local.tags
  private_dns     = var.private_dns
  client_config   = var.client_config
}