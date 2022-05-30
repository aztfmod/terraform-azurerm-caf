
module "diagnostics" {
  source = "../../diagnostics"
  count  = var.diagnostic_profiles == null ? 0 : 1

  resource_id       = jsondecode(azurerm_resource_group_template_deployment.ase.output_content).id.value
  resource_location = var.location
  diagnostics       = var.diagnostics
  profiles          = var.diagnostic_profiles
}