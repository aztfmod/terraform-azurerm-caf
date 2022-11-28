module "batch_applications" {
  source   = "./modules/compute/batch/batch_application"
  for_each = local.compute.batch_applications

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  batch_account   = local.combined_objects_batch_accounts[try(each.value.keyvault.lz_key, local.client_config.landingzone_key)][each.value.batch_account_key]
}

output "batch_applications" {
  value = module.batch_applications
}
