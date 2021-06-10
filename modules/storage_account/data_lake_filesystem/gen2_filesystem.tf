# Tested with :  AzureRM version 2.61.0
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_data_lake_gen2_filesystem

resource "azurerm_storage_data_lake_gen2_filesystem" "gen2" {
  name               = var.settings.name
  storage_account_id = var.storage_account_id
  properties = {
    for key, value in try(var.settings.properties) : key => base64encode(value)
  }
}