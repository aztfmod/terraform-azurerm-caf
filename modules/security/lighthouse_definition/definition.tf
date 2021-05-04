data "azurerm_role_definition" "role" {
  for_each = toset([for a in var.settings.authorizations : a.built_in_role_name])
  name     = each.value
}

resource "azurerm_lighthouse_definition" "definition" {
  name               = var.settings.name
  description        = var.settings.description
  managing_tenant_id = var.settings.managing_tenant_id
  scope = coalesce(
    try(format("/subscriptions/%s", var.resources["subscriptions"][try(var.settings.managed_subscription_id.lz_key, var.client_config.landingzone_key)][var.settings.managed_subscription_id.key].id), ""),
    try(var.settings.managed_subscription_id.id, "")
  )

  dynamic "authorization" {

    for_each = try(var.settings.authorizations, {})

    content {
      role_definition_id     = replace(lower(data.azurerm_role_definition.role[authorization.value.built_in_role_name].id), lower("//providers/Microsoft.Authorization/roleDefinitions//"), "")
      principal_display_name = authorization.value.principal_display_name
      # delegated_role_definitions = coalesce(
      #   flatten(
      #         [
      #           for key in try(authorization.value.delegated_role_definitions, []) : module.custom_roles[each.value.role_definition_name].role_definition_resource_id : null
      #         ]
      #     )
      # )
      principal_id = coalesce(
        try(var.resources["azuread_groups"][try(authorization.value.azuread_group.lz_key, var.client_config.landingzone_key)][authorization.value.azuread_group.key].id, ""),
        try(authorization.value.azuread_group.id, ""),

        try(var.resources["managed_identities"][try(authorization.value.managed_identity.lz_key, var.client_config.landingzone_key)][authorization.value.managed_identity.key].id, ""),
        try(authorization.value.managed_identity.id, ""),

        try(var.resources["azuread_users"][try(authorization.value.azuread_user.lz_key, var.client_config.landingzone_key)][authorization.value.azuread_user.key].id, ""),
        try(authorization.value.azuread_user.id, ""),

        try(var.resources["azuread_apps"][try(authorization.value.azuread_app.lz_key, var.client_config.landingzone_key)][authorization.value.azuread_app.key].id, ""),
        try(authorization.value.azuread_app.id, "")
      )

    }
  }
}
