module "diagnostics" {
  source = "../../diagnostics"
  for_each = var.eventgrid_domains

  // resource_id       = azurerm_eventgrid_domain.evgd.id
  // resource_location = azurerm_eventgrid_domain.evgd.location
  // diagnostics       = var.diagnostics
  // profiles          = try(var.settings.diagnostic_profiles, {})

  resource_id       = module.servicebus_namespaces[each.key].id
  resource_location = module.servicebus_namespaces[each.key].location
  diagnostics       = local.combined_diagnostics
  profiles          = try(each.value.diagnostic_profiles, {})
}