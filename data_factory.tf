##### azurerm_data_factory
module "data_factory" {
  source   = "./modules/data_factory/data_factory"
  for_each = local.data_factory.data_factory

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  base_tags = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group.key].tags : {}
  location  = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group.key].location : local.global_settings.regions[each.value.region]

  resource_group_name = coalesce(
    try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][each.value.resource_group.key].name, null),
    try(each.value.resource_group.name, null)
  )
  remote_objects = {
    managed_identities = local.combined_objects_managed_identities
    private_dns                     = local.combined_objects_private_dns
    vnets                           = local.combined_objects_networking
    private_endpoints               = try(each.value.private_endpoints, {})
    resource_groups                 = try(each.value.private_endpoints, {}) == {} ? null : local.resource_groups    
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

  resource_group_name = coalesce(
    try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][each.value.resource_group.key].name, null),
    try(each.value.resource_group.name, null)
  )
  data_factory_name = coalesce(
    try(local.combined_objects_data_factory[try(each.value.data_factory.lz_key, local.client_config.landingzone_key)][each.value.data_factory.key].name, null),
    try(each.value.data_factory.name, null)
  )
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

  resource_group_name = coalesce(
    try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][each.value.resource_group.key].name, null),
    try(each.value.resource_group.name, null)
  )
  data_factory_name = coalesce(
    try(local.combined_objects_data_factory[try(each.value.data_factory.lz_key, local.client_config.landingzone_key)][each.value.data_factory.key].name, null),
    try(each.value.data_factory.name, null)
  )
  pipeline_name = coalesce(
    try(local.combined_objects_data_factory_pipeline[try(each.value.data_factory_pipeline.lz_key, local.client_config.landingzone_key)][each.value.data_factory_pipeline.key].name, null),
    try(each.value.data_factory_pipeline.name, null)
  )
}
output "data_factory_trigger_schedule" {
  value = module.data_factory_trigger_schedule
}