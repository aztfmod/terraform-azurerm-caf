
resource "azurerm_mssql_managed_instance_transparent_data_encryption" "tde" {
  managed_instance_id = azurerm_mssql_managed_instance.example.id
}


resource "azurerm_mssql_managed_instance_transparent_data_encryption" "example" {
  managed_instance_id = azurerm_mssql_managed_instance.example.id
  key_vault_key_id    = azurerm_key_vault_key.example.id
}