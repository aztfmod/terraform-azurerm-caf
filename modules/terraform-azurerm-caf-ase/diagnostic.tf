# module "diagnostics" {
#   source  = "aztfmod/caf-diagnostics/azurerm"
#   version = "1.0"

#   name                       = azurecaf_naming_convention.ase.result
#   resource_id                = lookup(azurerm_template_deployment.ase.outputs, "id")
#   diag_object                = var.diag_object
#   diagnostics_map            = var.diagnostics_map
#   log_analytics_workspace_id = var.log_analytics_workspace_id
# }

module diagnostics {
  source = "/tf/caf/modules/diagnostics"
  count  = var.diagnostic_profiles == null ? 0 : 1

  resource_id       = lookup(azurerm_template_deployment.ase.outputs, "id")
  resource_location = var.location
  diagnostics       = var.diagnostics
  profiles          = var.diagnostic_profiles
}