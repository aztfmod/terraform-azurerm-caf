module "caf" {
  source          = "../../../../../"
  global_settings = var.global_settings
  tags            = var.tags
  resource_groups = var.resource_groups

  compute = {
    azure_container_registries = var.azure_container_registries
  }

  diagnostics = {
    diagnostics_destinations = var.diagnostics_destinations
    diagnostics_definition   = var.diagnostics_definition
    log_analytics            = var.log_analytics
  }

}