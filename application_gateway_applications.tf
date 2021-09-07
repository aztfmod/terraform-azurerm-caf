module "application_gateway_applications" {
  source   = "./modules/networking/application_gateway_application"
  for_each = local.networking.application_gateway_applications_v1

  client_config                 = local.client_config
  global_settings               = local.global_settings
  settings                      = each.value
  application_gateway           = local.combined_objects_application_gateway_platforms[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.application_gateway_key]
  app_services                  = local.combined_objects_app_services
  keyvault_certificate_requests = module.keyvault_certificate_requests
  keyvault_certificates         = module.keyvault_certificates
  keyvaults                     = local.combined_objects_keyvaults
}

output "application_gateway_applications_v1" {
  value = module.application_gateway_applications
}
