resource "azurecaf_name" "service" {
  name          = var.settings.name
  prefixes      = var.global_settings.prefixes
  resource_type = "azurerm_cognitive_account"
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_cognitive_account" "service" {
  name                = azurecaf_name.service.result
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = var.settings.kind
  sku_name            = var.settings.sku_name

  qna_runtime_endpoint = var.settings.kind == "QnAMaker" ? var.settings.qna_runtime_endpoint : try(var.settings.qna_runtime_endpoint, null)

  dynamic "network_acls" {
    for_each = can(var.settings.network_acls[0]) ? var.settings.network_acls[0] : []
    content {
      default_action             = network_acls.value.default_action
      ip_rules                   = try(network_acls.value.ip_rules, null)

      dynamic "virtual_network_rules" {
        for_each = can(network_acls.value.virtual_network_rules[0]) ? network_acls.value.virtual_network_rules[0] : []
        content {
          subnet_id                            = virtual_network_rules.value.subnet_id
          ignore_missing_vnet_service_endpoint = try(virtual_network_rules.value.ignore_missing_vnet_service_endpoint, null)
        }
      }
    }
  }

  custom_subdomain_name = try(var.settings.custom_subdomain_name, null)

  tags = try(var.settings.tags, {})
}