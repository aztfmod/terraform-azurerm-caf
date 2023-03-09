module "application_gateway_platforms" {
  source   = "./modules/networking/application_gateway_platform"
  for_each = local.networking.application_gateway_platforms

  depends_on = [module.keyvault_certificates, module.keyvault_certificate_requests, module.application_gateway_waf_policies]

  application_gateway_waf_policies = local.combined_objects_application_gateway_waf_policies
  client_config                    = local.client_config
  diagnostics                      = local.combined_diagnostics
  global_settings                  = local.global_settings
  keyvaults                        = local.combined_objects_keyvaults
  managed_identities               = local.combined_objects_managed_identities
  private_dns                      = lookup(each.value, "private_dns_records", null) == null ? {} : local.combined_objects_private_dns
  public_ip_addresses              = local.combined_objects_public_ip_addresses
  settings                         = each.value
  sku_name                         = each.value.sku_name
  sku_tier                         = each.value.sku_tier
  vnets                            = local.combined_objects_networking

  base_tags           = local.global_settings.inherit_tags
  resource_group      = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : null
  location            = try(local.global_settings.regions[each.value.region], null)

}

output "application_gateway_platforms" {
  value = module.application_gateway_platforms

}
