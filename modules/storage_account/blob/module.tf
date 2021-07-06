# Tested with :  AzureRM version 2.61.0
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_blob

resource "azurerm_storage_blob" "blob" {

  name                   = var.settings.name
  storage_account_name   = var.storage_account_name
  storage_container_name = var.storage_container_name
  type                   = try(var.settings.type, "Block")
  size                   = try(var.settings.size, null)
  access_tier            = try(var.settings.access_tier, "Hot")
  content_type           = try(var.settings.content_type, null)
  content_md5            = try(var.settings.content_md5, null)
  source                 = try(var.settings.source, null)
  source_content         = try(var.settings.source_content, null)
  source_uri             = try(var.settings.source_uri, null)
  parallelism            = try(var.settings.parallelism, 8)
  metadata               = try(var.settings.metadata, null)
}