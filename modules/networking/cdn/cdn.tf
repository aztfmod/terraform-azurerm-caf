resource "azurecaf_name" "cdn_profile_name" {
  name          = var.settings.name
  resource_type = "azurerm_cdn_profile"
  prefixes      = try(var.settings.global_settings.prefixes, var.global_settings.prefixes)
  random_length = try(var.settings.global_settings.random_length, var.global_settings.random_length)
  clean_input   = true
  passthrough   = try(var.settings.global_settings.passthrough, var.global_settings.passthrough)
  use_slug      = try(var.settings.global_settings.use_slug, var.global_settings.use_slug)
}

resource "azurerm_cdn_profile" "profile" {
  name                = azurecaf_name.cdn_profile_name.result
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.settings.sku
  tags                = local.tags
}

resource "azurerm_cdn_endpoint" "endpoint" {
  for_each            = local.endpoint_collection_map
  name                = each.value.endpoint_name
  profile_name        = azurerm_cdn_profile.profile.name
  location            = var.location
  resource_group_name = var.resource_group_name
  origin_host_header  = each.value.storage_host_name

  origin {
    name      = each.value.origin_name
    host_name = each.value.storage_host_name
  }

  delivery_rule {
    name  = each.value.delivery_rule_name
    order = each.value.delivery_order
    request_scheme_condition {
      match_values = [each.value.delivery_match_value]
      operator     = each.value.delivery_operator
    }
    url_redirect_action {
      redirect_type = each.value.delivery_redirect_type
      protocol      = each.value.delivery_protocol
    }
  }
}
