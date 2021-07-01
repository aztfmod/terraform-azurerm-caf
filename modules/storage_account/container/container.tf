# Tested with :  AzureRM version 2.61.0
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container

resource "azurerm_storage_container" "stg" {
  name                  = var.settings.name
  storage_account_name  = var.storage_account_name
  container_access_type = try(var.settings.container_access_type, "private")
  metadata              = try(var.settings.metadata, null)
}