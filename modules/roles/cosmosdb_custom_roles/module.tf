resource "azurecaf_name" "custom_role" {
  name          = var.name
  resource_type = "azurerm_role_definition"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_cosmosdb_sql_role_definition" "custom_role" {
  name                = azurecaf_name.custom_role.result
  resource_group_name = var.resource_group_name
  account_name        = var.account_name
  assignable_scopes   = var.assignable_scopes
  role_definition_id  = var.role_definition_id
  type                = var.type

  permissions {
    data_actions = var.permissions.data_actions
  }
}
