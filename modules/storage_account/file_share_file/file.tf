resource "azurerm_storage_share_file" "share_file" {
  name                = var.settings.name
  storage_share_id    = var.share_id
  path                = try(var.settings.path, null)
  source              = try(var.settings.source, null)
  content_type        = try(var.settings.content_type, null)
  content_md5         = try(var.settings.content_md5, null)
  content_encoding    = try(var.settings.content_encoding, null)
  content_disposition = try(var.settings.content_disposition, null)
  metadata            = try(var.settings.metadata, null)
}