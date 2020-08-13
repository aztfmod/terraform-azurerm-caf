module "diagnostics_az_fw" {
  source  = "aztfmod/caf-diagnostics/azurerm"
  version = "1.0.0"

  name                       = azurerm_firewall.az_firewall.name
  resource_id                = azurerm_firewall.az_firewall.id
  log_analytics_workspace_id = var.la_workspace_id
  diagnostics_map            = var.diagnostics_map
  diag_object                = var.diagnostics_settings
}