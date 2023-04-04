
resource "azurerm_mssql_managed_instance_transparent_data_encryption" "tde" {
  managed_instance_id = var.sqlmi_id
  key_vault_key_id    = try(var.key_vault_key_id, null)
}

