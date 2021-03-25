module "diagnostics" {
  source = "../../diagnostics"
  count  = var.diagnostic_profiles == null ? 0 : 1

  resource_id       = lookup(azurerm_firewall.fw, "id")
  resource_location = var.location
  diagnostics       = var.diagnostics
  profiles          = var.diagnostic_profiles
}