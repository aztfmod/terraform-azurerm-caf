module "storage_account_queues" {
  source               = "./modules/storage_account/queue"
  for_each             = local.storage.storage_account_queues
  storage_account_name = module.storage_accounts[each.value.storage_account_key].name
  settings             = each.value

}

output "storage_account_queues" {
  value = module.storage_account_queues

}