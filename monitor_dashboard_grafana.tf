output "monitor_dashboard_grafana" {
  value = module.monitor_dashboard_grafana
}

module "monitor_dashboard_grafana" {
  # depends_on          = [module.virtual_machine_scale_sets, module.app_service_plans]
  source = "./modules/monitoring/monitor_dashboard_grafana"

  for_each = local.shared_services.monitor_dashboard_grafana

  client_config       = local.client_config
  diagnostic_profiles = try(each.value.diagnostic_profiles, {})
  diagnostics         = local.combined_diagnostics
  global_settings     = local.global_settings
  managed_identities  = local.combined_objects_managed_identities
  settings            = each.value
  vnets               = local.combined_objects_networking
  subnets             = local.combined_objects_virtual_subnets
  private_dns         = local.combined_objects_private_dns

  base_tags           = local.global_settings.inherit_tags
  resource_group      = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : null
  location            = try(local.global_settings.regions[each.value.region], null)

}