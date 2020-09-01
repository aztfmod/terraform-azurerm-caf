resource "azurecaf_naming_convention" "custom_role" {
  name          = var.custom_role.name
  prefix        = lookup(var.custom_role, "useprefix", false) ? "" : var.global_settings.prefix
  resource_type = "rg" # workaround to keep the dashes
  convention    = lookup(var.custom_role, "convention", var.global_settings.convention)
}

resource "azurerm_role_definition" "custom_role" {
  name = azurecaf_naming_convention.custom_role.result

  # TODO: refactor scope to include other scopes like RG, resources.
  scope       = lookup(var.custom_role, "scope", var.subscription_primary)
  description = var.custom_role.description

  permissions {
    actions          = lookup(var.custom_role.permissions, "actions", [])
    not_actions      = lookup(var.custom_role.permissions, "not_actions", [])
    data_actions     = lookup(var.custom_role.permissions, "data_actions", [])
    not_data_actions = lookup(var.custom_role.permissions, "not_data_actions", [])
  }

  assignable_scopes = [lookup(var.custom_role, "scope", var.subscription_primary)]

}