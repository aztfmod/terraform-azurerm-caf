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
    for_each = can(var.settings.network_acls) == true ? [1] : [0]
    content {
      default_action             = var.settings.network_acls.default_action
      ip_rules                   = try(var.settings.network_acls.ip_rules, null)
      # virtual_network_subnet_ids = try(var.settings.network_acls.virtual_network_subnet_ids, null)
      dynamic "virtual_network_rules" {
        for_each = can(var.settings.network_acls.virtual_network_rules) == true ? [1] : [0]
        content {
          subnet_id = var.remote_objects.vnets[try(each.value.lz_key, var.client_config.landingzone_key)][each.value.vnet_key].subnets[each.value.subnet_key].id
          ignore_missing_vnet_service_endpoint = var.settings.network_acls.virtual_network_rules.ignore_missing_vnet_service_endpoint
        }
      } 
    }
  }

  custom_subdomain_name = try(var.settings.custom_subdomain_name, null)

  tags = try(var.settings.tags, {})
}