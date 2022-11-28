resource "azurerm_api_management_subscription" "apim" {
  api_management_name = var.api_management_name
  display_name        = var.settings.display_name
  resource_group_name = var.resource_group_name
  product_id          = try(var.settings.product_id, null)
  user_id             = try(var.settings.user_id, null)
  api_id              = try(var.settings.api_id, null)
  primary_key         = try(var.settings.primary_key, null)
  secondary_key       = try(var.settings.secondary_key, null)
  state               = try(var.settings.state, null)
  subscription_id     = try(var.settings.subscription_id, null)
  allow_tracing       = try(var.settings.allow_tracing, null)
}
