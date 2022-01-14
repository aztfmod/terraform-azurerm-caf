resource "azurerm_api_management_user" "apim" {
  api_management_name = var.api_management_name
  resource_group_name = var.resource_group_name
  email               = var.settings.email
  first_name          = var.settings.first_name
  last_name           = var.settings.last_name
  user_id             = var.settings.user_id
  confirmation        = try(var.settings.confirmation, null)
  note                = try(var.settings.note, null)
  password            = try(var.settings.password, null)
  state               = try(var.settings.state, null)
}