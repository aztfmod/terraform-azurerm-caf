module "file_share_file" {
  source     = "../file_share_file"
  depends_on = [module.file_share_directory]
  for_each   = try(var.settings.files, {})

  share_id = azurerm_storage_share.fs.id
  settings = each.value
}