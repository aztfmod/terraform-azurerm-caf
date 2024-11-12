output "aks_clusters" {
  value = module.aks_clusters
}

module "aks_clusters" {
  source     = "./modules/compute/aks"
  depends_on = [null_resource.register_feature_preview, module.networking, module.routes, module.azurerm_firewall_policies, module.application_gateways, module.application_gateway_platforms, module.application_gateway_applications]
  for_each   = local.compute.aks_clusters

  client_config       = local.client_config
  diagnostic_profiles = try(each.value.diagnostic_profiles, {})
  diagnostics         = local.combined_diagnostics
  global_settings     = local.global_settings
  managed_identities  = local.combined_objects_managed_identities
  settings            = each.value
  vnets               = local.combined_objects_networking
  azuread_applications = local.combined_objects_azuread_applications
  private_endpoints   = try(each.value.private_endpoints, {})

  admin_group_object_ids = try(each.value.admin_groups.azuread_group_keys, null) == null ? null : try(
    each.value.admin_groups.ids,
    [
      for group_key in try(each.value.admin_groups.azuread_group_keys, {}) :
      coalesce(
        try(local.combined_objects_azuread_groups[each.value.admin_groups.lz_key][group_key].id, null),
        try(local.combined_objects_azuread_groups[local.client_config.landingzone_key][group_key].id, null)
      )
    ]
  )

  application_gateway = can(each.value.addon_profile.ingress_application_gateway.key) ? local.combined_objects_application_gateway_platforms[try(each.value.addon_profile.ingress_application_gateway.lz_key, local.client_config.landingzone_key)][each.value.addon_profile.ingress_application_gateway.key] : null
  private_dns_zone_id = can(each.value.private_dns_zone.id) || can(each.value.private_dns_zone.key) == false ? try(each.value.private_dns_zone.id, null) : local.combined_objects_private_dns[try(each.value.private_dns_zone.lz_key, local.client_config.landingzone_key)][each.value.private_dns_zone.key].id

  base_tags           = local.global_settings.inherit_tags
  resource_group      = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : null
  location            = try(local.global_settings.regions[each.value.region], null)

}
