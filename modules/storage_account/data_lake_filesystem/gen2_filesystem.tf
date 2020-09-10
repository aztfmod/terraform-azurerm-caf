resource "azurerm_storage_data_lake_gen2_filesystem" "gen2" {
  name               = var.settings.name
  storage_account_id = var.storage_account_id
  properties = {
    for key, value in try(var.settings.properties) : key => base64encode(value)
  }
}