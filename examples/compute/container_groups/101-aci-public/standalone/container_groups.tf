module "aci" {
  source             = "../../../../..//modules/compute/container_group"
  depends_on = [module.caf]

  for_each = var.container_groups

  base_tags                    = try(module.caf.global_settings.inherit_tags, false) ? module.caf.resource_groups[each.value.resource_group_key].tags : {}
  client_config                = module.caf.client_config
  combined_diagnostics         = tomap({ (module.caf.client_config.landingzone_key) = module.caf.diagnostics })
  combined_managed_identities  = tomap({ (module.caf.client_config.landingzone_key) = module.caf.managed_identities })
  combined_vnets               = tomap({ (module.caf.client_config.landingzone_key) = module.caf.vnets })
  diagnostic_profiles          = try(each.value.diagnostic_profiles, {})
  global_settings              = module.caf.global_settings
  location                     = lookup(each.value, "region", null) == null ? module.caf.resource_groups[each.value.resource_group_key].location : module.caf.global_settings.regions[each.value.region]
  resource_group_name          = module.caf.resource_groups[each.value.resource_group_key].name
  settings                     = each.value

  combined_resources = {
    keyvaults          = tomap({ (module.caf.client_config.landingzone_key) = module.caf.keyvaults })
    managed_identities = tomap({ (module.caf.client_config.landingzone_key) = module.caf.managed_identities })
  }
}

# locals {
#   combined_resources = {
#     keyvaults = tomap({ (module.caf.client_config.landingzone_key) = module.caf.keyvaults })
#   }

#   z_environment_variables_from_resources = {
#     for mapping in
#     flatten(
#       [
#         for key, value in try(var.container_groups, {}) : [
#           for container_key, container_value in try(value.containers, {}) : [
#             for env_key, env_value in try(container_value.environment_variables_from_resources, {}) :
#             {
#               key = key
#               container_key = container_key
#               env_key = env_key
#               # value = env_value
#               value = local.combined_resources[env_value.output_key][try(env_value.lz_key, module.caf.client_config.landingzone_key)][env_value.resource_key][env_value.attribute_key]
#             }
#           ]
#         ]
#       ]
#     ) : mapping.key => mapping
#   }
# }

# output  environment_variables_from_resources {
#  value = {
#     for key, value in try(var.container_groups["rover_2102_0100-1"].containers, {}) : key => flatten(
#       [
#         for variable_name, resource_keys in try(value.environment_variables_from_resources, {}) : {
#           variable_name = resource_keys
#       #  variable_name = local.combined_resources[resource_keys.output_key][try(resource_keys.lz_key, module.caf.client_config.landingzone_key)][resource_keys.resource_key][resource_keys.attribute_key]
#         }
#       ]
#     )
#   }
# }

output  environment_variables_from_resources_list {
  value = module.aci
}

# output zz_environment_variables_from_resources {
#   value = {
#     for item in local.z_environment_variables_from_resources : item.env_key => item.value
#   }
# }

output aci {
  value = module.aci
}