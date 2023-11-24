module "container_app_environment_storages" {
  source   = "./modules/compute/container_app_environment_storage"
  for_each = local.compute.container_app_environment_storages

  base_tags                    = local.global_settings.inherit_tags
  container_app_environment_id = can(each.value.container_app_environment_id) ? each.value.container_app_environment_id : local.combined_objects_container_app_environments[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.container_app_environment_key].id
  client_config                = local.client_config
  global_settings              = local.global_settings
  combined_resources = {
    storage_accounts = local.combined_objects_storage_accounts
  }
  settings = each.value
}

output "container_app_environment_storages" {
  value = module.container_app_environment_storages
}

