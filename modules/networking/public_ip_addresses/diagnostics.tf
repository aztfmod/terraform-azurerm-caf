module "diagnostics" {
  source = "../../diagnostics"

  resource_id       = azurerm_public_ip.pip.id
  resource_location = local.location
  diagnostics       = var.diagnostics
  profiles          = var.diagnostic_profiles
}