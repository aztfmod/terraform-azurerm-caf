module "private_endpoint" {
  source   = "../../networking/private_endpoint"
  for_each = var.private_endpoints

  resource_id         = azurerm_logic_app_standard.logic_app_standard.id
  name                = each.value.name
  location            = lookup(var.settings, "region", null) == null ? local.resource_group.location : var.global_settings.regions[var.settings.region]
  resource_group_name = local.resource_group.name
  subnet_id = coalesce(
    try(each.value.subnet_id, null),
    try(var.vnets[var.client_config.landingzone_key][each.value.vnet_key].subnets[each.value.subnet_key].id, null),
    try(var.vnets[each.value.lz_key][each.value.vnet_key].subnets[each.value.subnet_key].id, null),
    try(var.virtual_subnets[var.client_config.landingzone_key][each.value.subnet_key].id, null),
    try(var.virtual_subnets[each.value.lz_key][each.value.subnet_key].id, null)
  )

  settings        = each.value
  global_settings = var.global_settings
  base_tags       = var.base_tags
  private_dns     = var.private_dns
  client_config   = var.client_config

}