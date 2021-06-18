resource "azurecaf_name" "dhg" {
  name          = var.settings.name
  resource_type = "azurerm_dedicated_host_group"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

# Last review :  AzureRM version 2.63.0
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dedicated_host_group


resource "azurerm_dedicated_host_group" "dhg" {
  name                        = azurecaf_name.dhg.result
  resource_group_name         = var.resource_group_name
  location                    = var.location
  platform_fault_domain_count = var.settings.platform_fault_domain_count
  automatic_placement_enabled = try(var.settings.automatic_placement_enabled, false)
  zones                       = try(var.settings.zones, null)
  tags                        = local.tags
}