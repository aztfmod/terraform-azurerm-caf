resource "azurecaf_name" "sp" {
  name          = var.settings.name
  resource_type = "azurerm_storage_account"
  prefixes      = [var.global_settings.prefix]
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
}

resource "azurerm_synapse_sql_pool" "sql_pool" {
  name                 = azurecaf_name.sp.result
  synapse_workspace_id = azurerm_synapse_workspace.synapse_wrkspc.id
  sku_name             = try(var.settings.sql_pool.sku_name, "DW100c")
  create_mode          = try(var.settings.sql_pool.create_mode, "Default")
}

