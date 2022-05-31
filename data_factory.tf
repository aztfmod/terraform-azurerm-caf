##### azurerm_data_factory
module "data_factory" {
  source   = "./modules/data_factory/data_factory"
  for_each = local.data_factory.data_factory

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  diagnostics         = local.combined_diagnostics
  diagnostic_profiles = try(each.value.diagnostic_profiles, {})
  location            = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  base_tags           = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
  resource_groups     = local.combined_objects_resource_groups

  remote_objects = {
    managed_identities = local.combined_objects_managed_identities
    private_dns        = local.combined_objects_private_dns
    vnets              = local.combined_objects_networking
    private_endpoints  = try(each.value.private_endpoints, {})
    resource_groups    = try(each.value.private_endpoints, {}) == {} ? null : local.combined_objects_resource_groups
  }

}

output "data_factory" {
  value = module.data_factory
}

##### azurerm_data_factory_pipeline
module "data_factory_pipeline" {
  source   = "./modules/data_factory/data_factory_pipeline"
  for_each = local.data_factory.data_factory_pipeline

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(local.client_config.landingzone_key, each.value.resource_group.lz_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  data_factory_id     = can(each.value.data_factory.id) ? each.value.data_factory.id : local.combined_objects_data_factory[try(local.client_config.landingzone_key, each.value.data_factory.lz_key)][try(each.value.data_factory.key, each.value.data_factory_key)].id
}

output "data_factory_pipeline" {
  value = module.data_factory_pipeline
}

##### azurerm_data_factory_trigger_schedule
module "data_factory_trigger_schedule" {
  source   = "./modules/data_factory/data_factory_trigger_schedule"
  for_each = local.data_factory.data_factory_trigger_schedule

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(local.client_config.landingzone_key, each.value.resource_group.lz_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  data_factory_id     = can(each.value.data_factory.id) ? each.value.data_factory.id : local.combined_objects_data_factory[try(local.client_config.landingzone_key, each.value.data_factory.lz_key)][try(each.value.data_factory.key, each.value.data_factory_key)].id
  pipeline_name       = can(each.value.data_factory_pipeline.name) ? each.value.data_factory_pipeline.name : local.combined_objects_data_factory_pipeline[try(each.value.data_factory_pipeline.lz_key, local.client_config.landingzone_key)][each.value.data_factory_pipeline.key].name

}

output "data_factory_trigger_schedule" {
  value = module.data_factory_trigger_schedule
}

module "data_factory_integration_runtime_self_hosted" {
  source   = "./modules/data_factory/data_factory_integration_runtime_self_hosted"
  for_each = local.data_factory.data_factory_integration_runtime_self_hosted

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  data_factory_id     = can(each.value.data_factory.id) ? each.value.data_factory.id : local.combined_objects_data_factory[try(local.client_config.landingzone_key, each.value.data_factory.lz_key)][try(each.value.data_factory.key, each.value.data_factory_key)].id
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(local.client_config.landingzone_key, each.value.resource_group.lz_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name

  remote_objects = {
    data_factory   = local.combined_objects_data_factory
    resource_group = local.combined_objects_resource_groups
  }
}
output "data_factory_integration_runtime_self_hosted" {
  value = module.data_factory_integration_runtime_self_hosted
}

module "data_factory_integration_runtime_azure_ssis" {
  source   = "./modules/data_factory/data_factory_integration_runtime_azure_ssis"
  for_each = local.data_factory.data_factory_integration_runtime_azure_ssis

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  data_factory_id     = can(each.value.data_factory.id) ? each.value.data_factory.id : local.combined_objects_data_factory[try(local.client_config.landingzone_key, each.value.data_factory.lz_key)][try(each.value.data_factory.key, each.value.data_factory_key)].id
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(local.client_config.landingzone_key, each.value.resource_group.lz_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  location            = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(local.client_config.landingzone_key, each.value.resource_group.lz_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location


  remote_objects = {
    resource_groups          = local.combined_objects_resource_groups
    keyvaults                = local.combined_objects_keyvaults
    dynamic_keyvault_secrets = local.security.dynamic_keyvault_secrets
  }
}
output "data_factory_integration_runtime_azure_ssis" {
  value = module.data_factory_integration_runtime_azure_ssis
}
