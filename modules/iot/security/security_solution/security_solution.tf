# Terraform azurerm resource: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iot_security_solution

resource "azurecaf_name" "iot_security_solution" {
  name          = var.settings.name
  resource_type = "azurerm_iot_security_solution"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_iot_security_solution" "securitysolution" {
  name                = azurecaf_name.iot_security_solution.result
  resource_group_name = local.resource_group_name
  location            = local.location
  iothub_ids          = var.iothub_ids
  display_name        = var.settings.display_name

  dynamic "additional_workspace" {
    for_each = lookup(var.settings, "additional_workspace", {}) == {} ? [] : [1]
    content {
      data_types   = var.settings.additional_workspace.data_types
      workspace_id = var.settings.additional_workspace.workspace_id
    }
  }

  disabled_data_sources      = try(var.settings.disabled_data_sources, null)
  enabled                    = try(var.settings.disabled_data_sources, true)
  events_to_export           = try(var.settings.events_to_export, null)
  log_analytics_workspace_id = try(var.settings.log_analytics_workspace_id, null)
  log_unmasked_ips_enabled   = try(var.settings.log_unmasked_ips_enabled, null)

  dynamic "recommendations_enabled" {
    for_each = lookup(var.settings, "recommendations_enabled", {}) == {} ? [] : [1]
    content {
      acr_authentication               = try(var.settings.recommendations_enabled.acr_authentication, null)
      agent_send_unutilized_msg        = try(var.settings.recommendations_enabled.agent_send_unutilized_msg, null)
      baseline                         = try(var.settings.recommendations_enabled.baseline, null)
      edge_hub_mem_optimize            = try(var.settings.recommendations_enabled.edge_hub_mem_optimize, null)
      edge_logging_option              = try(var.settings.recommendations_enabled.edge_logging_option, null)
      inconsistent_module_settings     = try(var.settings.recommendations_enabled.inconsistent_module_settings, null)
      install_agent                    = try(var.settings.recommendations_enabled.install_agent, null)
      ip_filter_deny_all               = try(var.settings.recommendations_enabled.ip_filter_deny_all, null)
      ip_filter_permissive_rule        = try(var.settings.recommendations_enabled.ip_filter_permissive_rule, null)
      open_ports                       = try(var.settings.recommendations_enabled.open_ports, null)
      permissive_firewall_policy       = try(var.settings.recommendations_enabled.permissive_firewall_policy, null)
      permissive_input_firewall_rules  = try(var.settings.recommendations_enabled.permissive_input_firewall_rules, null)
      permissive_output_firewall_rules = try(var.settings.recommendations_enabled.permissive_output_firewall_rules, null)
      privileged_docker_options        = try(var.settings.recommendations_enabled.privileged_docker_options, null)
      shared_credentials               = try(var.settings.recommendations_enabled.shared_credentials, null)
      vulnerable_tls_cipher_suite      = try(var.settings.recommendations_enabled.vulnerable_tls_cipher_suite, null)
    }
  }

  query_for_resources    = try(var.settings.query_for_resources, null)
  query_subscription_ids = try(var.settings.query_subscription_ids, null)

  tags = merge(local.tags, lookup(var.settings, "tags", {}))
}
