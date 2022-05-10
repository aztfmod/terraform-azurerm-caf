module "diagnostics" {
  source = "../../diagnostics"
  count  = try(var.settings.diagnostic_profiles, null) == null ? 0 : 1

  resource_id       = azurerm_storage_account.stg.id
  resource_location = azurerm_storage_account.stg.location
  diagnostics       = var.diagnostics
  profiles          = try(var.settings.diagnostic_profiles, {})
}
