
module "diagnostics" {
  source   = "../../diagnostics"
  for_each = var.diagnostic_profiles == null ? toset([]) : toset(["enabled"])

  resource_id       = azurerm_virtual_desktop_application_group.dag.id
  resource_location = var.location
  diagnostics       = var.diagnostics
  profiles          = var.diagnostic_profiles
}