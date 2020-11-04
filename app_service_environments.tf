
module "app_service_environments" {
  source = "./modules/webapps/ase"

  for_each = local.webapp.app_service_environments

  settings                  = each.value
  resource_group_name       = module.resource_groups[each.value.resource_group_key].name
  location                  = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : var.global_settings.regions[each.value.region]
  tags                      = try(each.value.tags, null)
  base_tags                 = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
  name                      = each.value.name
  kind                      = try(each.value.kind, "ASEV2")
  zone                      = try(each.value.zone, null)
  subnet_id                 = lookup(each.value, "lz_key", null) == null ? local.combined_objects_networking[local.client_config.landingzone_key][each.value.vnet_key].subnets[each.value.subnet_key].id : local.combined_objects_networking[each.value.lz_key][each.value.vnet_key].subnets[each.value.subnet_key].id
  subnet_name               = lookup(each.value, "lz_key", null) == null ? local.combined_objects_networking[local.client_config.landingzone_key][each.value.vnet_key].subnets[each.value.subnet_key].name : local.combined_objects_networking[each.value.lz_key][each.value.vnet_key].subnets[each.value.subnet_key].name
  internalLoadBalancingMode = each.value.internalLoadBalancingMode
  front_end_size            = try(each.value.front_end_size, "Standard_D1_V2")
  diagnostic_profiles       = try(each.value.diagnostic_profiles, null)
  diagnostics               = local.diagnostics
  global_settings           = local.global_settings
  private_dns               = lookup(each.value, "private_dns_records", null) == null ? {} : local.combined_objects_private_dns
}


output "app_service_environments" {
  value     = module.app_service_environments
  sensitive = true
}