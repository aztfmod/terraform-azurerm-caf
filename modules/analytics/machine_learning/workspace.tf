# naming convention
resource "azurecaf_name" "ws" {
  name          = var.settings.name
  prefixes      = [var.global_settings.prefix]
  resource_type = "azurerm_machine_learning_workspace"
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

# ML Workspace
resource "azurerm_machine_learning_workspace" "ws" {
  name                    = azurecaf_name.ws.result
  location                = var.location
  resource_group_name     = var.resource_group_name
  application_insights_id = var.application_insights_id
  key_vault_id            = var.keyvault_id
  storage_account_id      = var.storage_account_id
  tags                    = try(local.tags, null)
  sku_name                = try(var.settings.sku_name, "basic")

  identity {
    type = "SystemAssigned"
  }
}


