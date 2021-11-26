module "application_gateways" {
  depends_on = [module.keyvault_certificate_requests]
  source     = "./modules/networking/application_gateway"
  for_each   = local.networking.application_gateways

  app_services                     = local.combined_objects_app_services
  application_gateway_waf_policies = local.combined_objects_application_gateway_waf_policies
  client_config                    = local.client_config
  diagnostics                      = local.combined_diagnostics
  dns_zones                        = local.combined_objects_dns_zones
  global_settings                  = local.global_settings
  keyvault_certificate_requests    = module.keyvault_certificate_requests
  keyvault_certificates            = module.keyvault_certificates
  keyvaults                        = local.combined_objects_keyvaults
  managed_identities               = local.combined_objects_managed_identities
  private_dns                      = lookup(each.value, "private_dns_records", null) == null ? {} : local.combined_objects_private_dns
  public_ip_addresses              = local.combined_objects_public_ip_addresses
  settings                         = each.value
  sku_name                         = each.value.sku_name
  sku_tier                         = each.value.sku_tier
  vnets                            = local.combined_objects_networking

  application_gateway_applications = {
    for key, value in local.networking.application_gateway_applications : key => value
    if value.application_gateway_key == each.key
  }

  resource_group_name = coalesce(
    try(local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group.key].name, null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group.key].name, null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group_key].name, null),
    try(each.value.resource_group.name, null)
  )
  base_tags = try(local.global_settings.inherit_tags, false) ? coalesce(
    try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][each.value.resource_group.key].tags, null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group_key].tags, null)
  ) : {}
  location = lookup(each.value, "region", null) == null ? coalesce(
    try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][each.value.resource_group.key].location, null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group_key].location, null)
  ) : local.global_settings.regions[each.value.region]
}

output "application_gateways" {
  value = module.application_gateways

}

output "application_gateway_applications" {
  value = local.networking.application_gateway_applications

}
