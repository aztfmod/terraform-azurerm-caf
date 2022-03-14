##### database_migration_services
module "database_migration_services" {
  source = "./modules/databases/database_migration_service"

  for_each = local.database.database_migration_services

  client_config       = local.client_config
  location            = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  settings            = each.value
  global_settings     = local.global_settings
  base_tags           = try(local.global_settings.inherit_tags, false) ? local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags : {}

  remote_objects = {
    vnets = local.combined_objects_networking
  }
}

output "database_migration_services" {
  value = module.database_migration_services
}

##### database_migration_projects
module "database_migration_projects" {
  source = "./modules/databases/database_migration_project"

  for_each = local.database.database_migration_projects

  client_config               = local.client_config
  location                    = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  resource_group_name         = local.resource_groups[each.value.resource_group_key].name
  database_migration_services = local.combined_objects_database_migration_services
  settings                    = each.value
  global_settings             = local.global_settings
  base_tags                   = try(local.global_settings.inherit_tags, false) ? local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags : {}
  remote_objects = {
    vnets = local.combined_objects_networking
  }
}

output "database_migration_projects" {
  value = module.database_migration_projects
}