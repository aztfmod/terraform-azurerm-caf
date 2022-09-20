resource "azurecaf_name" "asev3" {
  name          = var.settings.name
  resource_type = "azurerm_app_service_environment"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_app_service_environment_v3" "asev3" {
  name                                   = azurecaf_name.asev3.result
  resource_group_name                    = var.resource_group_name
  subnet_id                              = var.subnet_id
  internal_load_balancing_mode           = try(var.settings.internal_load_balancing_mode, null)
  allow_new_private_endpoint_connections = try(var.settings.allow_new_private_endpoint_connections, null)
  dedicated_host_count                   = try(var.settings.dedicated_host_count, null)
  zone_redundant                         = try(var.settings.zone_redundant, null)
  tags                                   = try(local.tags, null)

  dynamic "cluster_setting" {
    for_each = can(var.settings.cluster_settings) ? var.settings.cluster_settings : []

    content {
      name  = cluster_setting.name
      value = cluster_setting.value
    }
  }

  dynamic "cluster_setting" {
    for_each = can(var.settings.cluster_settings) ? [1] : []

    content {
      name  = "FrontEndSSLCipherSuiteOrder"
      value = "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256"
    }
  }
}