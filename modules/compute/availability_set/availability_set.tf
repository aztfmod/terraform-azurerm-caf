resource "azurerm_availability_set" "avset" {
  name                         = azurecaf_name.avset.result
  location                     = var.location
  resource_group_name          = var.resource_group_name
  tags                         = local.tags
  platform_update_domain_count = var.settings.platform_update_domain_count
  platform_fault_domain_count  = var.settings.platform_fault_domain_count
  managed                      = try(var.settings.managed, true)
  proximity_placement_group_id = var.ppg_id

}

resource "azurecaf_name" "avset" {

  name          = var.settings.name
  resource_type = "azurerm_availability_set"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

