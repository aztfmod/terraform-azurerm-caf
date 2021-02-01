resource "azurerm_netapp_pool" "pool" {
  # The capacity pool name must be unique for each NetApp account
  name                = var.settings.name
  account_name        = var.account_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_level       = try(var.settings.service_level, "Standard")
  size_in_tb          = try(var.settings.size_in_tb, 4)
  tags                = merge(var.base_tags, try(var.settings.tags, {}))
}

module volumes {
  source   = "../volume"
  for_each = try(var.settings.volumes, {})
  settings = each.value

  resource_group_name = var.resource_group_name
  location            = var.location
  account_name        = var.account_name
  pool_name           = azurerm_netapp_pool.pool.name
  service_level       = azurerm_netapp_pool.pool.service_level
  subnet_id           = try(var.vnets[var.client_config.landingzone_key][each.value.vnet_key].subnets[each.value.subnet_key].id, var.vnets[each.value.lz_key][each.value.vnet_key].subnets[each.value.subnet_key].id)
  #export_policy_rule  # need to be implemented
  tags = merge(var.base_tags, try(each.value.tags, {}))

}
