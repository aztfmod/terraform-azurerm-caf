module "file_share_directory" {
  source   = "../file_share_directory"
  for_each = try(var.settings.directories, {})

  storage_account_name = var.storage_account_name
  share_name           = azurerm_storage_share.fs.name
  settings             = each.value
}