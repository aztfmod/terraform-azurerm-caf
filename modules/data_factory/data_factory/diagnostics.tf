module "diagnostics" {
  source = "../../diagnostics"

  resource_id       = azurerm_data_factory.df.id
  resource_location = local.location
  diagnostics       = var.diagnostics
  profiles          = var.diagnostic_profiles
}
