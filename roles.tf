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
