locals {
  # Expected Variable: dynamic_app_settings = {
  #                      "KEYVAULT_URL" = {
  #                         keyvaults = {
  #                           my_common_vault = {
  #                             lz_key = "common_services_lz"
  #                             attribute_key = "vault_uri"
  #                           }
  #                         }
  #                      }
  #                     }
  dynamic_settings_to_process = {
    for setting in
    flatten(
      [
        for setting_name, resources in var.dynamic_app_settings : [
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
}