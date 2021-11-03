module "storage_containers" {
  source   = "./modules/storage_account/container/"
  for_each = local.storage.storage_containers

  settings = each.value

  storage_account_name = coalesce(
    try(local.combined_objects_storage_accounts[each.value.storage_account.lz_key][each.value.storage_account.key].name, null),
    try(local.combined_objects_storage_accounts[local.client_config.landingzone_key][each.value.storage_account.key].name, null),
    try(each.value.storage_account.name, null)
  )

}
output "storage_containers" {
  value = module.storage_containers
}