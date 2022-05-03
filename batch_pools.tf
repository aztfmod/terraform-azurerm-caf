module "batch_pools" {
  source   = "./modules/compute/batch/batch_pool"
  for_each = local.compute.batch_pools

  global_settings    = local.global_settings
  client_config      = local.client_config
  settings           = each.value
  batch_account      = local.combined_objects_batch_accounts[try(each.value.keyvault.lz_key, local.client_config.landingzone_key)][each.value.batch_account_key]
  batch_certificates = local.combined_objects_batch_certificates
  vnets              = local.combined_objects_networking
}

output "batch_pools" {
  value = module.batch_pools
}
