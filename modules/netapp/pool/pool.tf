resource "azurecaf_name" "pool" {
  name          = var.settings.name
  prefixes      = var.global_settings.prefixes
  resource_type = "azurerm_netapp_pool"
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_netapp_pool" "pool" {
  # The capacity pool name must be unique for each NetApp account
  name                = azurecaf_name.pool.result
  account_name        = var.account_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_level       = try(var.settings.service_level, "Standard")
  size_in_tb          = try(var.settings.size_in_tb, 4)
  tags                = merge(var.base_tags, try(var.settings.tags, {}))
  lifecycle {
    ignore_changes = [resource_group_name, location, name]
  }

}

module "volumes" {
  source   = "../volume"
  for_each = try(var.settings.volumes, {})
  settings = each.value

  resource_group_name = var.resource_group_name
  location            = var.location
  account_name        = var.account_name
  pool_name           = azurerm_netapp_pool.pool.name
  service_level       = azurerm_netapp_pool.pool.service_level
  subnet_id           = can(each.value.subnet_id) ? each.value.subnet_id : var.vnets[try(each.value.lz_key, var.client_config.landingzone_key)][each.value.vnet_key].subnets[each.value.subnet_key].id
  export_policy_rule  = try(each.value.export_policy_rule, {})
  tags                = merge(var.base_tags, try(each.value.tags, {}))
  global_settings     = var.global_settings
}
