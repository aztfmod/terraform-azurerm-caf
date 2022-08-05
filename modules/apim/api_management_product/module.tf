resource "azurerm_api_management_product" "apim" {
  api_management_name   = var.api_management_name
  resource_group_name   = var.resource_group_name
  display_name          = var.settings.display_name
  description           = try(var.settings.description, null)
  product_id            = try(var.settings.product_id, null)
  approval_required     = try(var.settings.approval_required, false)
  subscription_required = try(var.settings.subscription_required, false)
  published             = try(var.settings.published, false)
  subscriptions_limit   = try(var.settings.subscriptions_limit, null)
  terms                 = try(var.settings.terms, null)
}