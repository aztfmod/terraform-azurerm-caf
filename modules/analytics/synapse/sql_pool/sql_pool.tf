resource "azurecaf_name" "sqlpool" {
  name          = var.settings.name
  resource_type = "azurerm_synapse_sql_pool"
  prefixes      = [var.global_settings.prefix]
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
}

resource "azurerm_synapse_sql_pool" "sql_pool" {
  name                 = azurecaf_name.sqlpool.result
  synapse_workspace_id = var.synapse_workspace_id
  sku_name             = try(var.settings.sku_name, "DW100c")
  create_mode          = try(var.settings.create_mode, "Default")
}
