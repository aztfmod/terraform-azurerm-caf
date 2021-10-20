module "storage_containers" {
  source   = "./modules/storage_container/"
  for_each = local.storage.storage_containers

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  storage_account_name = coalesce(
    try(local.combined_objects_storage_accounts[each.value.storage_account.lz_key][each.value.storage_account.key].name, null),
    try(local.combined_objects_storage_accounts[local.client_config.landingzone_key][each.value.storage_account.key].name, null),
    try(each.value.storage_account.name, null)
  )


  combined_resources = {
    storage_account = local.combined_objects_storage_accounts
  }
}
output "storage_containers" {
  value = module.storage_containers
}