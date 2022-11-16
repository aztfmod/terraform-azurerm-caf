
module "diagnostics" {
  source = "../../diagnostics"
  count  = try(var.settings.diagnostic_profiles, null) == null ? 0 : 1

  resource_id       = azurerm_network_security_group.nsg.id
  resource_location = var.location
  diagnostics       = var.diagnostics
  profiles          = var.settings.diagnostic_profiles
}