##### azurerm_data_factory
module "data_factory" {
  source = "./modules/data_factory/data_factory"

  for_each = local.data_factory.data_factory

  name                 = each.value.name
  resource_group_name  = module.resource_groups[each.value.resource_group_key].name
  location             = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  github_configuration = try(each.value.github_configuration, null)
  identity             = try(each.value.identity, null)
  vsts_configuration   = try(each.value.vsts_configuration, null)
  global_settings      = local.global_settings
  base_tags            = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
  tags                 = try(each.value.tags, null)
}

output "data_factory" {
  value = module.data_factory
}

##### azurerm_data_factory_pipeline
module "data_factory_pipeline" {
  source = "./modules/data_factory/data_factory_pipeline"

  for_each = local.data_factory.data_factory_pipeline

  name                = each.value.name
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  data_factory_name   = module.data_factory[each.value.data_factory_key].name
  description         = try(each.value.description, null)
  annotations         = try(each.value.annotations, null)
  parameters          = try(each.value.parameters, null)
  variables           = try(each.value.variables, null)
  activities_json     = try(each.value.activities_json, null)
}

output "data_factory_pipeline" {
  value = module.data_factory_pipeline
}

##### azurerm_data_factory_trigger_schedule
module "data_factory_trigger_schedule" {
  source = "./modules/data_factory/data_factory_trigger_schedule"

  for_each = local.data_factory.data_factory_trigger_schedule

  name                = each.value.name
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  data_factory_name   = module.data_factory[each.value.data_factory_key].name
  pipeline_name       = module.data_factory_pipeline[each.value.data_factory_pipeline_key].name
  start_time          = try(each.value.start_time, null)
  end_time            = try(each.value.end_time, null)
  interval            = try(each.value.interval, null)
  frequency           = try(each.value.frequency, null)
  pipeline_parameters = try(each.value.pipeline_parameters, null)
  annotations         = try(each.value.annotations, null)
}

output "data_factory_trigger_schedule" {
  value = module.data_factory_trigger_schedule
}