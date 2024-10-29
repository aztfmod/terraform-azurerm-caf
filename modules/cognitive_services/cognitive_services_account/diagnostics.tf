module "diagnostics" {
  source = "../../diagnostics"
  for_each = try(var.settings.diagnostic_profiles, {})
  resource_id       = azurerm_cognitive_account.service.id
  resource_location = azurerm_cognitive_account.service.location
  diagnostics       = var.remote_objects.diagnostics
  profiles          = try(var.settings.diagnostic_profiles, {})
}
