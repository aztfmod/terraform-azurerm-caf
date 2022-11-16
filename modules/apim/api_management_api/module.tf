resource "azurecaf_name" "apim" {
  name          = var.settings.name
  resource_type = "azurerm_api_management_api"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_api_management_api" "apim" {
  name = azurecaf_name.apim.result

  api_management_name = var.api_management_name
  resource_group_name = var.resource_group_name
  revision            = var.settings.revision
  display_name        = try(var.settings.display_name, null)
  path                = try(var.settings.path, null)
  protocols           = try(var.settings.protocols, null)
  description         = try(var.settings.description, null)
  dynamic "import" {
    for_each = try(var.settings.import, null) != null ? [var.settings.import] : []

    content {

      content_format = try(import.value.content_format, null)
      content_value  = try(import.value.content_value, null)
      dynamic "wsdl_selector" {
        for_each = try(var.settings.wsdl_selector, null) != null ? [var.settings.wsdl_selector] : []

        content {

          service_name  = try(wsdl_selector.value.service_name, null)
          endpoint_name = try(wsdl_selector.value.endpoint_name, null)
        }
      }
    }
  }
  dynamic "oauth2_authorization" {
    for_each = try(var.settings.oauth2_authorization, null) != null ? [var.settings.oauth2_authorization] : []

    content {

      authorization_server_name = try(oauth2_authorization.value.authorization_server_name, null)
      scope                     = try(oauth2_authorization.value.scope, null)
    }
  }
  dynamic "openid_authentication" {
    for_each = try(var.settings.openid_authentication, null) != null ? [var.settings.openid_authentication] : []

    content {

      openid_provider_name         = try(openid_authentication.value.openid_provider_name, null)
      bearer_token_sending_methods = try(openid_authentication.value.bearer_token_sending_methods, null)
    }
  }
  service_url       = try(var.settings.service_url, null)
  soap_pass_through = try(var.settings.soap_pass_through, null)
  dynamic "subscription_key_parameter_names" {
    for_each = try(var.settings.subscription_key_parameter_names, null) != null ? [var.settings.subscription_key_parameter_names] : []

    content {

      header = try(subscription_key_parameter_names.value.header, null)
      query  = try(subscription_key_parameter_names.value.query, null)
    }
  }
  subscription_required = try(var.settings.subscription_required, null)
  version               = try(var.settings.version, null)
  version_set_id        = try(var.settings.version_set_id, null)
  revision_description  = try(var.settings.revision_description, null)
  version_description   = try(var.settings.version_description, null)
  source_api_id         = try(var.settings.source_api_id, null)
}