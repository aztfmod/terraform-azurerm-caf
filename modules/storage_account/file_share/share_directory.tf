module "file_share_directory" {
  source   = "../file_share_directory"
  for_each = try(var.settings.directories, {})
  storage_share_id     = azurerm_storage_share.fs.id
  share_name           = azurerm_storage_share.fs.name
  settings             = each.value
}