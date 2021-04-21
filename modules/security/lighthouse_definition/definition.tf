data "azurerm_role_definition" "role" {
  name = var.settings.built_in_role_name
}

locals {
  role_id = regex("[^\\/]+$", data.azurerm_role_definition.role.role_definition_id)
}

resource "azurerm_lighthouse_definition" "definition" {
  name               = var.settings.name
  description        = var.settings.description
  managing_tenant_id = var.settings.managing_tenant_id
  scope = coalesce(
    try(format("/subscription/%s", var.resources["subscriptions"][try(var.settings.definition_scope.subscription.lz_key, var.client_config.landingzone_key)][var.settings.definition_scope.subscription.key].id), ""),
    try(var.settings.definition_scope.subscription.id, "")
  )

  dynamic "authorization" {
    # verify syntax
    for_each = try(var.settings.authorizations, {})
    
    
    content {
      principal_id = coalesce(
      try(authorization.value.managed_identity.id, ""),
      try(var.resources["managed_identities"][try(authorization.value.managed_identity.lz_key, var.client_config.landingzone_key)][authorization.value.managed_identity.key].id, ""),

      try(authorization.value.azuread_group.azuread_group.id, ""),
      try(var.resources["azuread_groups"][try(authorization.value.azuread_group.lz_key, var.client_config.landingzone_key)][authorization.value.azuread_group.azuread_group.key].id, ""),

      try(authorization.value.azuread_group.azuread_user.id, ""),
      try(var.resources["azuread_users"][try(authorization.value.azuread_group.azuread_user.lz_key, var.client_config.landingzone_key)][authorization.value.azuread_group.azuread_user.key].id, ""),

      try(authorization.value.azuread_group.azuread_app.id, ""),
      try(var.resources["azuread_apps"][try(authorization.value.azuread_group.azuread_app.lz_key, var.client_config.landingzone_key)][authorization.value.azuread_group.azuread_app.key].id, "")
    )
    }
  }

  # authorization {
  #   principal_id = coalesce(
  #     try(var.settings.definition_scope.managed_identity.id, ""),
  #     try(var.resources["managed_identities"][try(var.settings.definition_scope.managed_identity.lz_key, var.client_config.landingzone_key)][var.settings.definition_scope.managed_identity.key].id, ""),

  #     try(var.settings.definition_scope.azuread_group.id, ""),
  #     try(var.resources["azuread_groups"][try(var.settings.definition_scope.azuread_group.lz_key, var.client_config.landingzone_key)][var.settings.definition_scope.azuread_group.key].id, ""),

  #     try(var.settings.definition_scope.azuread_user.id, ""),
  #     try(var.resources["azuread_users"][try(var.settings.definition_scope.azuread_user.lz_key, var.client_config.landingzone_key)][var.settings.definition_scope.azuread_user.key].id, ""),

  #     try(var.settings.definition_scope.azuread_app.id, ""),
  #     try(var.resources["azuread_apps"][try(var.settings.definition_scope.azuread_app.lz_key, var.client_config.landingzone_key)][var.settings.definition_scope.azuread_app.key].id, "")
  #   )
  #   role_definition_id     = local.role_id
  #   principal_display_name = var.settings.authorization.principal_display_name
  # }

}

