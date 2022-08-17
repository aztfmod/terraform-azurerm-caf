resource "azurerm_api_management_subscription" "apim" {
  api_management_name = var.api_management_name
  display_name        = var.settings.display_name
  resource_group_name = var.resource_group_name
  user_id             = try(coalesce(
                        try(var.remote_objects.api_management_user[var.settings.api_management_user.lz_key][var.settings.api_management_user.key].id, null),
                        try(var.remote_objects.api_management_user[var.client_config.landingzone_key][var.settings.api_management_user.key].id, null),
                        try(var.settings.api_management_user.id, null)
                        ),null)
  product_id          = try(coalesce(
                        try(var.remote_objects.api_management_product[var.settings.api_management_product.lz_key][var.settings.api_management_product.key].id, null),
                        try(var.remote_objects.api_management_product[var.client_config.landingzone_key][var.settings.api_management_product.key].id, null),
                        try(var.settings.api_management_product.product_id, null)
                      ),null)
  api_id              = try(coalesce(
                        try(var.remote_objects.api_management_api[var.settings.api_management_api.lz_key][var.settings.api_management_api.key].id, null),
                        try(var.remote_objects.api_management_api[var.client_config.landingzone_key][var.settings.api_management_api.key].id, null),
                        try(var.settings.api_management_api.id, null)
                      ),null)              
  primary_key         = try(var.settings.primary_key, null)
  secondary_key       = try(var.settings.secondary_key, null)
  state               = try(var.settings.state, null)
  subscription_id     = try(var.settings.subscription_id, null)
  allow_tracing       = try(var.settings.allow_tracing, null)
}
