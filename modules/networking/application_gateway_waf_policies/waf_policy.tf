resource "azurerm_web_application_firewall_policy" "wafpolicy" {

  name                = var.settings.name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = local.tags

  dynamic "custom_rules" {
    for_each = try(var.settings.custom_rules, {})
    content {
      name      = custom_rules.value.name
      priority  = custom_rules.value.priority
      rule_type = custom_rules.value.rule_type
      action    = custom_rules.value.action

      dynamic "match_conditions" {
        for_each = custom_rules.value.match_conditions
        content {
          match_values       = match_conditions.value.match_values
          operator           = match_conditions.value.operator
          negation_condition = try(match_conditions.value.negation_condition, null)
          transforms         = try(match_conditions.value.transforms, null)

          dynamic "match_variables" {
            for_each = match_conditions.value.match_variables
            content {
              variable_name = match_variables.value.variable_name
              selector      = try(match_variables.value.selector, null)
            }
          }
        }
      }
    }
  }

  dynamic "policy_settings" {
    for_each = try(var.settings.policy_settings, {}) != {} ? [1] : []
    content {
      enabled                     = try(var.settings.policy_settings.enabled, null)
      mode                        = try(var.settings.policy_settings.mode, null)
      file_upload_limit_in_mb     = try(var.settings.policy_settings.file_upload_limit_in_mb, null)
      request_body_check          = try(var.settings.policy_settings.request_body_check, null)
      max_request_body_size_in_kb = try(var.settings.policy_settings.max_request_body_size_in_kb, null)
    }
  }

  dynamic "managed_rules" {
    for_each = try(var.settings.managed_rules, {}) != {} ? [1] : []
    content {
      dynamic "exclusion" {
        for_each = try(var.settings.managed_rules.exclusions, {})
        content {
          match_variable          = exclusion.value.match_variable
          selector                = try(exclusion.value.selector, null)
          selector_match_operator = exclusion.value.selector_match_operator
        }
      }
      dynamic "managed_rule_set" {
        for_each = var.settings.managed_rules.managed_rule_set
        content {
          type    = try(managed_rule_set.value.type, null)
          version = managed_rule_set.value.version

          dynamic "rule_group_override" {
            for_each = try(managed_rule_set.value.rule_group_override, {})
            content {
              rule_group_name = rule_group_override.value.rule_group_name
              disabled_rules  = try(rule_group_override.value.disabled_rules, null)
            }
          }
        }
      }
    }
  }
}