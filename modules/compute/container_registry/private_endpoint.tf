
module "private_endpoint" {
  source   = "../../networking/private_endpoint"
  for_each = var.private_endpoints

  base_tags           = local.tags
  client_config       = var.client_config
  global_settings     = var.global_settings
  location            = var.resource_groups[var.client_config.landingzone_key][each.value.resource_group_key].location
  name                = each.value.name
  private_dns         = var.private_dns
  resource_group_name = var.resource_groups[var.client_config.landingzone_key][each.value.resource_group_key].name
  resource_id         = azurerm_container_registry.acr.id
  settings            = each.value

  subnet_id = coalesce(
    try(each.value.subnet_id, null),
    try(var.vnets[var.client_config.landingzone_key][each.value.vnet_key].subnets[each.value.subnet_key].id, null),
    try(var.vnets[each.value.lz_key][each.value.vnet_key].subnets[each.value.subnet_key].id, null)
  )
}
