## Need to implement naming convention --> check with provider status

resource "azurerm_dedicated_host_group" "dhg" {
  name                        = var.settings.name
  resource_group_name         = var.resource_group_name
  location                    = var.location
  platform_fault_domain_count = var.settings.platform_fault_domain_count
  automatic_placement_enabled = try(var.settings.automatic_placement_enabled, false)
  zones                       = try(var.settings.zones, null)
  tags                        = local.tags
}