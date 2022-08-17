resource "azurerm_api_management_product" "apim" {
  product_id            = var.settings.name
  api_management_name = coalesce(
    try(var.remote_objects.api_management[var.settings.api_management.lz_key][var.settings.api_management.key].name, null),
    try(var.remote_objects.api_management[var.client_config.landingzone_key][var.settings.api_management.key].name, null),
    try(var.settings.api_management.name, null)
  )

  resource_group_name = coalesce(
    try(var.remote_objects.resource_group[var.settings.resource_group.lz_key][var.settings.resource_group.key].name, null),
    try(var.remote_objects.resource_group[var.client_config.landingzone_key][var.settings.resource_group.key].name, null),
    try(var.settings.resource_group.name, null)
  )

  display_name          = var.settings.display_name
  subscription_required = var.settings.subscription_required
  approval_required     = var.settings.approval_required
  published             = var.settings.published
  description           = try(var.settings.description, null)
  subscriptions_limit   = try(var.settings.subscriptions_limit, null)
  terms                 = try(var.settings.terms, null)
}
