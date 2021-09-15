##### azurerm_data_factory
module "data_factory" {
  source   = "./modules/data_factory/data_factory"
  for_each = local.data_factory.data_factory

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name

  base_tags = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}
  location  = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
}

output "data_factory" {
  value = module.data_factory
}

##### azurerm_data_factory_pipeline
module "data_factory_pipeline" {
  source   = "./modules/data_factory/data_factory_pipeline"
  for_each = local.data_factory.data_factory_pipeline

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name

  data_factory_name = try(each.value.lz_key, null) == null ? local.combined_objects_data_factory[local.client_config.landingzone_key][each.value.data_factory_key].name : local.combined_objects_data_factory[each.value.lz_key][each.value.data_factory_key].name
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

  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  data_factory_name   = try(each.value.lz_key, null) == null ? local.combined_objects_data_factory[local.client_config.landingzone_key][each.value.data_factory_key].name : local.combined_objects_data_factory[each.value.lz_key][each.value.data_factory_key].name
  pipeline_name       = try(each.value.lz_key, null) == null ? local.combined_objects_data_factory_pipeline[local.client_config.landingzone_key][each.value.data_factory_pipeline_key].name : local.combined_objects_data_factory_pipeline[each.value.lz_key][each.value.data_factory_pipeline_key].name
}
output "data_factory_trigger_schedule" {
  value = module.data_factory_trigger_schedule
}