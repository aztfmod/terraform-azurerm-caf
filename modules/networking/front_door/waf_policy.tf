resource "azurerm_frontdoor_firewall_policy" "wafpolicy" {
  for_each = var.settings.waf_policy
  
  name                              = var.settings.waf_policy.name
  resource_group_name               = var.resource_group_name
  enabled                           = var.settings.waf_policy.enabled
  mode                              = var.settings.waf_policy.mode
  redirect_url                      = var.settings.waf_policy.redirect_url
  custom_block_response_status_code = var.settings.waf_policy.custom_block_response_status_code
  custom_block_response_body        = var.settings.waf_policy.custom_block_response_body
  tags                              = local.tags
  
  dynamic "custom_rule" {
    for_each = var.settings.waf_policy.custom_rule
    content {
      name                           = custom_rule.value.name
      enabled                        = custom_rule.value.enabled
      priority                       = custom_rule.value.priority
      rate_limit_duration_in_minutes = custom_rule.value.rate_limit_duration_in_minutes
      rate_limit_threshold           = custom_rule.value.rate_limit_threshold
      type                           = custom_rule.value.type
      action                         = custom_rule.value. action

      dynamic "match_condition" {
        for_each = custom_rule.value.match_condition
        content {
          match_variable     = match_condition.value.match_variable
          operator           = match_condition.value.operator
          negation_condition = match_condition.value.negation_condition
          match_values       = match_condition.value.match_values
        }
      }
    }
  }

  dynamic "managed_rule" {
    for_each = var.settings.waf_policy.managed_rule
    content {
      type                           = managed_rule.value.type
      version                        = managed_rule.value.version
      
      dynamic "exclusion" {
        for_each = managed_rule.value.exclusion
        content {
          match_variable     = exclusion.value.match_variable
          operator           = exclusion.value.operator
          selector           = exclusion.value.selector
        }
      }      

    }
  }

}