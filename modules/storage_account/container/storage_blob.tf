module "blob" {
  source     = "../blob"
  depends_on = [azurerm_storage_container.stg]
  for_each   = try(var.settings.storage_blobs, {})

  storage_account_name   = var.storage_account_name
  storage_container_name = var.settings.name
  settings               = each.value
}