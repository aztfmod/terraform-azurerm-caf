resource "azurerm_api_management_product" "apim" {
  api_management_name   = var.api_management_name
  resource_group_name   = var.resource_group_name
  display_name          = var.settings.display_name
  product_id            = var.settings.product_id
  description           = try(var.settings.description, null)
  approval_required     = try(var.settings.approval_required, null)
  subscription_required = var.settings.subscription_required
  published             = var.settings.published
  subscriptions_limit   = try(var.settings.subscriptions_limit, null)
  terms                 = try(var.settings.terms, null)
}

resource "azurerm_api_management_product_policy" "apim" {
  count               = try(var.settings.policy, null) != null ? 1 : 0
  api_management_name = var.api_management_name
  resource_group_name = var.resource_group_name
  product_id          = var.settings.product_id

  xml_content = try(
    try(
      file("${path.cwd}/${var.settings.policy.xml_file}"),
      var.settings.policy.xml_content
    ),
    null
  )

  xml_link = try(var.settings.policy.xml_link, null)
}
