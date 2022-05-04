resource "azurecaf_name" "fdre" {
  name          = var.settings.name
  resource_type = "azurerm_frontdoor" #"azurerm_frontdoor_rules_engine"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_frontdoor_rules_engine" "fdre" {
  name = azurecaf_name.fdre.result

  frontdoor_name      = var.frontdoor_name
  resource_group_name = var.resource_group_name

  dynamic "rule" {
    for_each = try(var.settings.rule, {})

    content {
      name     = rule.value.name
      priority = rule.value.priority
      dynamic "action" {
        for_each = try(rule.value.action, null) != null ? [rule.value.action] : []

        content {
          dynamic "request_header" {
            for_each = try(action.value.request_header, {})

            content {
              header_action_type = request_header.value.header_action_type
              header_name        = request_header.value.header_name
              value              = request_header.value.value
            }
          }
          dynamic "response_header" {
            for_each = try(action.value.response_header, {})

            content {
              header_action_type = response_header.value.header_action_type
              header_name        = response_header.value.header_name
              value              = response_header.value.value
            }
          }
        }
      }
      dynamic "match_condition" {
        for_each = try(rule.value.match_condition, {})

        content {
          variable         = match_condition.value.variable
          selector         = match_condition.value.selector
          operator         = match_condition.value.operator
          transform        = match_condition.value.transform
          negate_condition = match_condition.value.negate_condition
          value            = match_condition.value.value
        }
      }
    }
  }
}
