
module "diagnostics" {
  source   = "../../diagnostics"
  for_each = var.diagnostic_profiles == null ? toset([]) : toset(["enabled"])

  resource_id       = azurerm_virtual_desktop_host_pool.wvdpool.id
  resource_location = var.location
  diagnostics       = var.diagnostics
  profiles          = var.diagnostic_profiles
}