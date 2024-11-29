module "app_config" {
  source   = "./modules/databases/app_config"
  for_each = local.database.app_config
  name     = each.value.name

  client_config       = local.client_config
  combined_objects    = local.dynamic_app_config_combined_objects
  global_settings     = local.global_settings
  settings            = each.value
  vnets               = local.combined_objects_networking
  private_dns         = local.combined_objects_private_dns
  base_tags           = local.global_settings.inherit_tags
  resource_group      = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : null
  location            = try(local.global_settings.regions[each.value.region], null)
}

resource "azurerm_app_configuration_key" "kv" {
  for_each = try(local.config_settings, {})

  configuration_store_id = local.combined_objects_app_config[try(local.database.app_config_entries.lz_key, local.client_config.landingzone_key)][local.database.app_config_entries.key].id
  key                    = each.key
  label                  = try(each.value.label, null)
  value                  = each.value.value
}

output "app_config" {
  value = module.app_config
}

locals {
  dynamic_settings_to_process = {
    for setting in
    flatten(
      [
        for setting_name, resources in try(local.database.app_config_entries.dynamic_settings, []) : [
          for resource_type_key, resource in resources : [
            for object_id_key, object_attributes in resource : {
              key = setting_name
              value = {
                value = try(local.dynamic_app_config_combined_objects[resource_type_key][object_attributes.lz_key][object_id_key][object_attributes.attribute_key], local.combined_objects_app_config[resource_type_key][var.client_config.landingzone_key][object_id_key][object_attributes.attribute_key])
                label = try(object_attributes.label, null)
              }
            }
          ]
        ]
      ]
    ) : setting.key => setting.value
  }

  config_settings = merge(try(local.database.app_config_entries.settings, {}), try(local.dynamic_settings_to_process, {}))
}
