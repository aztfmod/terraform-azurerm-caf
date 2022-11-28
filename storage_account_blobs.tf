#
# Storage account blobs can be created as a nested object or isolated to allow RBAC to be set before writing the blob
#

resource "time_sleep" "delay" {
  depends_on = [azurerm_role_assignment.for]
  for_each   = local.storage.storage_account_blobs

  create_duration = "300s"
}

module "storage_account_blobs" {
  source     = "./modules/storage_account/blob"
  depends_on = [time_sleep.delay]
  for_each   = local.storage.storage_account_blobs


  storage_account_name   = module.storage_accounts[each.value.storage_account_key].name
  storage_container_name = each.value.storage_container_name
  settings               = each.value
}

output "storage_account_blobs" {
  value = module.storage_account_blobs

}
