resource "azurecaf_name" "manageddb" {

  name          = var.settings.name
  resource_type = "azurerm_mssql_database"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
}

resource "azurerm_mssql_managed_database" "sqlmanageddatabase" {
  name                = azurecaf_name.manageddb.name
  managed_instance_id = try(var.server_id, null)
  depends_on = [
    azurecaf_name.manageddb
  ]

}



