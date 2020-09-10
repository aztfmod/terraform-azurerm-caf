module custom_roles {
  source   = "./modules/custom_roles"
  for_each = var.custom_role_definitions

  global_settings      = local.global_settings
  subscription_primary = data.azurerm_subscription.primary.id
  custom_role          = each.value
}

#
# Roles assignments
#
# Require the modules output an rbac_id that is set to the principal_id
#

resource "azurerm_role_assignment" "for" {
  for_each = try(local.roles_to_process, {})

  scope                = local.services_roles[each.value.scope_resource_key][each.value.scope_key_resource].id
  role_definition_name = each.value.mode == "built_in_role_mapping" ? each.value.role_definition_name : null
  role_definition_id   = each.value.mode == "custom_role_mapping" ? module.custom_roles[each.value.role_definition_name].id : null
  principal_id = each.value.object_id_resource_type == "object_ids" ? each.value.object_id_key_resource : local.services_roles[each.value.object_id_resource_type][each.value.object_id_key_resource].rbac_id
}

locals {
  services_roles = {
    aks_clusters               = module.aks_clusters
    azure_container_registries = module.container_registry
    azuread_groups             = module.azuread_groups
    azuread_apps               = module.azuread_applications
    azuread_users              = module.azuread_users
    resource_groups            = module.resource_groups
    managed_identities         = module.managed_identities
    storage_accounts           = module.storage_accounts
    synapse_workspaces         = module.synapse_workspaces
    subscriptions              = merge(try(var.subscriptions, {}), { "logged_in_subscription" = { id = data.azurerm_subscription.primary.id } })
    logged_in = {
      user = {
        rbac_id = local.client_config.logged_user_objectId
      }
      app = {
        rbac_id = local.client_config.logged_aad_app_objectId
      }
    }
  }


  roles_to_process = {
    for mapping in
    flatten(
      [
        for key_mode, all_role_mapping in var.role_mapping : [
          for key, role_mappings in all_role_mapping : [
            for scope_key_resource, role_mapping in role_mappings : [
              for role_definition_name, resources in role_mapping : [
                for object_id_key, object_resources in resources : [
                  for object_id_key_resource in object_resources :
                  {
                    mode                    = key_mode
                    scope_resource_key      = key
                    object_id_resource_type = object_id_key
                    scope_key_resource      = scope_key_resource
                    role_definition_name    = role_definition_name
                    object_id_key_resource  = object_id_key_resource
                  }
                ]
              ]
            ]
          ]
        ]
      ]
    ) : format("%s-%s-%s", mapping.scope_key_resource, replace(mapping.role_definition_name, " ", "_"), mapping.object_id_key_resource) => mapping
  }

}

# The code transform this input format to
#   custom_role_mapping = {
  #     subscription_keys = {
  #       logged_in_subscription = {
  #         "caf-launchpad-contributor" = {
  #           azuread_group_keys = [
  #             "keyvault_level0_rw", "keyvault_level1_rw", "keyvault_level2_rw", "keyvault_level3_rw", "keyvault_level4_rw",
  #           ]
  #           managed_identity_keys = [
  #             "level0", "level1", "level2", "level3", "level4"
  #           ]
  #         }
  #       }
  #     }
  #   }

  #   built_in_role_mapping = {
  #     aks_clusters = {
  #       seacluster = {
  #         "Azure Kubernetes Service Cluster Admin Role" = {
  #           azuread_group_keys = [
  #             "aks_admins"
  #           ]
  #           managed_identity_keys = [
  #             "jumpbox"
  #           ]
  #         }
  #       }
  #     }
  #     azure_container_registries = {
  #       acr1 = {
  #         "AcrPull" = {
  #           aks_cluster_keys = [
  #             "seacluster"
  #           ]
  #         }
  #       }
  #     }
  #     storage_account_keys = {
  #       level0 = {
  #         "Storage Blob Data Contributor" = {
  #           logged_in_keys = [
  #             "user", "app"
  #           ]
  #           object_ids = [
  #             "232134243242342", "1111111"
  #           ]
  #           azuread_group_keys = [
  #             "keyvault_level0_rw"
  #           ]
  #           azuread_app_keys = [
  #             "caf_launchpad_level0"
  #           ]
  #           managed_identity_keys = [
  #             "level0"
  #           ]
  #         }
  #       }
  # ......

## Generates a transformed structure for azurerm_role_assignment to process 
# built_in_roles = {
#   "acr1_AcrPull_seacluster" = {
#     "mode" = "built_in_role_mapping"
#     "object_id_key_resource" = "seacluster"
#     "object_id_resource_type" = "aks_cluster_keys"
#     "role_definition_name" = "AcrPull"
#     "scope_key_resource" = "acr1"
#     "scope_resource_key" = "azure_container_registries"
#   }
#   "logged_in_subscription_caf-launchpad-contributor_keyvault_level0_rw" = {
#     "mode" = "custom_role_mapping"
#     "object_id_key_resource" = "keyvault_level0_rw"
#     "object_id_resource_type" = "azuread_group_keys"
#     "role_definition_name" = "caf-launchpad-contributor"
#     "scope_key_resource" = "logged_in_subscription"
#     "scope_resource_key" = "subscription_keys"
#   }
#   "logged_in_subscription_caf-launchpad-contributor_keyvault_level1_rw" = {
#     "mode" = "custom_role_mapping"
#     "object_id_key_resource" = "keyvault_level1_rw"
#     "object_id_resource_type" = "azuread_group_keys"
#     "role_definition_name" = "caf-launchpad-contributor"
#     "scope_key_resource" = "logged_in_subscription"
#     "scope_resource_key" = "subscription_keys"
#   }
#   "logged_in_subscription_caf-launchpad-contributor_keyvault_level2_rw" = {
#     "mode" = "custom_role_mapping"
#     "object_id_key_resource" = "keyvault_level2_rw"
#     "object_id_resource_type" = "azuread_group_keys"
#     "role_definition_name" = "caf-launchpad-contributor"
#     "scope_key_resource" = "logged_in_subscription"
#     "scope_resource_key" = "subscription_keys"
#   }
#   "logged_in_subscription_caf-launchpad-contributor_keyvault_level3_rw" = {
#     "mode" = "custom_role_mapping"
#     "object_id_key_resource" = "keyvault_level3_rw"
#     "object_id_resource_type" = "azuread_group_keys"
#     "role_definition_name" = "caf-launchpad-contributor"
#     "scope_key_resource" = "logged_in_subscription"
#     "scope_resource_key" = "subscription_keys"
#   }
# .......