data "azurerm_role_definition" "role" {
  for_each = toset([for a in var.settings.authorizations : a.built_in_role_name])
  name     = each.value
}

# Need to update after azure rm release

# data "azurerm_role_definition" "delegated_role" {
#   for_each = toset([for a in var.settings.authorizations : 
#   {for key, value in try(a.delegated_role_definitions,{}) : key => value }])
#   name     = each.value
# }


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
