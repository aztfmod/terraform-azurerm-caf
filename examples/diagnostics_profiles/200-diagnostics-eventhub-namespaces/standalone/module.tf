module "caf" {
  source          = "../../../../"
  resource_groups = var.resource_groups
  tags            = var.tags
  diagnostics = {
    diagnostics_definition          = var.diagnostics_definition
    diagnostics_destinations        = var.diagnostics_destinations
    diagnostic_event_hub_namespaces = var.diagnostic_event_hub_namespaces
  }

}

output "objects" {
  value = module.caf
}