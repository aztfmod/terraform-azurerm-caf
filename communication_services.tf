module "communication_services" {
  source   = "./modules/communication_service"
  for_each = try(local.communication.communication_services, {})

  global_settings     = local.global_settings
  client_config       = local.client_config
  name                = each.value.name
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  data_location       = try(each.value.data_location, null)
  tags                = try(each.value.tags, {})
  diagnostics         = local.combined_diagnostics
  diagnostic_profiles = try(each.value.diagnostic_profiles, {})
  resource_groups     = local.resource_groups
  base_tags           = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}
}

output "communication_services" {
  value = module.communication_services

}

