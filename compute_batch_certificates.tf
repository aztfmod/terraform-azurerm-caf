module "batch_certificates" {
  source   = "./modules/compute/batch/batch_certificate"
  for_each = local.compute.batch_certificates

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  batch_account   = local.combined_objects_batch_accounts[try(each.value.keyvault.lz_key, local.client_config.landingzone_key)][each.value.batch_account_key]
  certificate     = filebase64(format("%s/%s", path.cwd, each.value.certificate_filename))
}

output "batch_certificates" {
  value = module.batch_certificates
}
