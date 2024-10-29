resource "azurecaf_name" "service" {
  name          = var.settings.name
  prefixes      = var.global_settings.prefixes
  suffixes      = var.global_settings.suffixes
  random_length = var.global_settings.random_length
  random_seed   = var.global_settings.random_seed
  resource_type = "azurerm_cognitive_account"
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_cognitive_account" "service" {
  name                = azurecaf_name.service.result
  resource_group_name = local.resource_group_name
  location            = local.location
  kind                = var.settings.kind
  sku_name            = var.settings.sku_name

  # all of `custom_subdomain_name,network_acls` must be specified
  custom_subdomain_name = var.settings.custom_subdomain_name != null && length(var.settings.network_acls) > 0 ? var.settings.custom_subdomain_name : null
  dynamic_throttling_enabled = try(var.settings.dynamic_throttling_enabled, null)
  #checkov:skip=CKV2_AZURE_22:Ensure that Cognitive Services enables customer-managed key for encryption. This is a conditional resource
  dynamic "customer_managed_key" {
    for_each = can(var.settings.customer_managed_key) ? [var.settings.customer_managed_key] : []
    content {
      key_vault_key_id = customer_managed_key.value.key_vault_key_id
      identity_client_id = try(customer_managed_key.value.identity_client_id, null)
    }
  }
  fqdns = try(var.settings.fqdns, [])
  dynamic "identity" {
    for_each = can(var.settings.identity) ? [var.settings.identity] : []
    content {
      type         = identity.value.type
      identity_ids = concat(local.managed_identities, try(identity.value.identity_ids, []))
    }
  }
  local_auth_enabled = try(var.settings.local_auth_enabled, true)
  metrics_advisor_aad_client_id = (var.settings.kind == "MetricsAdvisor" || var.settings.kind == "QnAMaker") ? try(var.settings.metrics_advisor_aad_client_id, null) : null
  metrics_advisor_super_user_name = (var.settings.kind == "MetricsAdvisor" || var.settings.kind == "QnAMaker") ? try(var.settings.metrics_advisor_super_user_name, null) : null
  metrics_advisor_website_name = (var.settings.kind == "MetricsAdvisor" || var.settings.kind == "QnAMaker") ? try(var.settings.metrics_advisor_website_name, null) : null
  dynamic "network_acls" {
    for_each = can(var.settings.network_acls) ? [var.settings.network_acls] : []
    content {
      default_action = network_acls.value.default_action
      ip_rules       = try(network_acls.value.ip_rules, null)
      dynamic "virtual_network_rules" {
        for_each = can(network_acls.value.virtual_network_rules) ? [network_acls.value.virtual_network_rules] : []
        content {
          subnet_id = can(virtual_network_rules.value.subnet_id) || can(virtual_network_rules.value.subnet_key) ? try(virtual_network_rules.value.subnet_id, var.remote_objects.virtual_subnets[try(virtual_network_rules.value.lz_key, var.client_config.landingzone_key)][virtual_network_rules.value.subnet_key].id) : var.remote_objects.vnets[try(virtual_network_rules.value.lz_key, var.client_config.landingzone_key)][virtual_network_rules.value.vnet_key].subnets[virtual_network_rules.value.subnet_key].id
          # Depurar en algún moment, error: The given key does not identify an element in this collection value.
          # subnet_id = var.remote_objects.subnet_id
          #  Try virtual_network_rules.value.subnet_id and if it is null, try to get the subnet_id from the remote_objects and if it is null, use null
          # subnet_id = try(virtual_network_rules.value.subnet_id, try(var.remote_objects.subnet_id, null))
          ignore_missing_vnet_service_endpoint = try(virtual_network_rules.value.ignore_missing_vnet_service_endpoint, null)
        }
      }
    }
  }
  outbound_network_access_restricted = try(var.settings.outbound_network_access_restricted, false)
  public_network_access_enabled = try(var.settings.public_network_access_enabled, true)
  qna_runtime_endpoint = var.settings.kind == "QnAMaker" ? var.settings.qna_runtime_endpoint : try(var.settings.qna_runtime_endpoint, null)
  custom_question_answering_search_service_id = var.settings.kind == "TextAnalytics" ? var.settings.custom_question_answering_search_service_id : try(var.settings.custom_question_answering_search_service_id, null)
  custom_question_answering_search_service_key = var.settings.kind == "TextAnalytics" ? var.settings.custom_question_answering_search_service_key : try(var.settings.custom_question_answering_search_service_key, null)
  dynamic "storage" {
    for_each = can(var.settings.storage) ? [var.settings.storage] : []

    content {
      storage_account_id = storage.value.storage_account_id
      identity_client_id = try(storage.value.identity_client_id, null)
    }
  }

  tags = try(var.settings.tags, {})
}