resource "azurerm_frontdoor_firewall_policy" "wafpolicy" {

  name                              = var.settings.name
  resource_group_name               = var.resource_group_name
  enabled                           = try(var.settings.enabled, true)
  mode                              = try(var.settings.mode, null)
  redirect_url                      = try(var.settings.redirect_url, null)
  custom_block_response_status_code = try(var.settings.custom_block_response_status_code, null)
  custom_block_response_body        = try(var.settings.custom_block_response_body, null)
  tags                              = local.tags

  dynamic "custom_rule" {
    for_each = try(var.settings.custom_rules, {})
    content {
      action                         = custom_rule.value.action
      enabled                        = try(custom_rule.value.enabled, true)
      name                           = custom_rule.value.name
      priority                       = custom_rule.value.priority
      rate_limit_duration_in_minutes = try(custom_rule.value.rate_limit_duration_in_minutes, 1)
      rate_limit_threshold           = try(custom_rule.value.rate_limit_threshold, 10)
      type                           = custom_rule.value.type

      dynamic "match_condition" {
        for_each = custom_rule.value.match_condition
        content {
          match_variable     = match_condition.value.match_variable
          operator           = match_condition.value.operator
          negation_condition = try(match_condition.value.negation_condition, null)
          match_values       = lower(match_condition.value.operator) == "geomatch" ? flatten([for key in match_condition.value.match_values : [local.countries[lower(key)]]]) : match_condition.value.match_values
          selector           = try(match_condition.value.selector, null)
          transforms         = try(match_condition.value.transforms, null)
        }
      }
    }
  }

  dynamic "managed_rule" {
    for_each = try(var.settings.managed_rules, {})
    content {
      type    = managed_rule.value.type
      version = managed_rule.value.version

      dynamic "exclusion" {
        for_each = try(managed_rule.value.exclusions, {})
        content {
          match_variable = exclusion.value.match_variable
          operator       = exclusion.value.operator
          selector       = exclusion.value.selector
        }
      }

      dynamic "override" {
        for_each = try(managed_rule.value.overrides, {})
        content {
          rule_group_name = override.value.rule_group_name

          dynamic "exclusion" {
            iterator = override_exclusion
            for_each = try(override.value.exclusions, {})
            content {
              match_variable = override_exclusion.value.match_variable
              operator       = override_exclusion.value.operator
              selector       = override_exclusion.value.selector
            }
          }

          dynamic "rule" {
            for_each = try(override.value.rules, {})
            content {
              rule_id = rule.value.rule_id
              action  = rule.value.action
              enabled = try(rule.value.enabled, false)

              dynamic "exclusion" {
                iterator = rule_exclusion
                for_each = try(rule.value.exclusions, {})
                content {
                  match_variable = rule_exclusion.value.match_variable
                  operator       = rule_exclusion.value.operator
                  selector       = rule_exclusion.value.selector
                }
              }
            }
          }

        }
      }

    }
  }

}