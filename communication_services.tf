module "communication_services" {
  source   = "./modules/communication/communication_services"
  for_each = try(local.communication.communication_services, {})

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  base_tags           = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}
}

output "communication_services" {
  value = module.communication_services

}

module "communication_services_diagnostics" {
  source   = "./modules/diagnostics"
  for_each = local.communication.communication_services

  resource_id       = module.communication_services[each.key].id
  resource_location = local.resource_groups[each.value.resource_group_key].location
  diagnostics       = local.combined_diagnostics
  profiles          = try(each.value.diagnostic_profiles, {})
}