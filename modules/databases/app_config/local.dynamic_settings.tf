locals {
  dynamic_settings_to_process = {
    for setting in
    flatten(
      [
        for setting_name, resources in try(var.settings.dynamic_settings, []) : [
          for resource_type_key, resource in resources : [
            for object_id_key, object_attributes in resource : {
              key   = setting_name
              value = try(var.combined_objects[resource_type_key][object_attributes.lz_key][object_id_key][object_attributes.attribute_key], var.combined_objects[resource_type_key][var.client_config.landingzone_key][object_id_key][object_attributes.attribute_key])
            }
          ]
        ]
      ]
    ) : setting.key => setting.value
  }

  config_settings = merge(try(var.settings.settings, {}), try(local.dynamic_settings_to_process, {}))
}