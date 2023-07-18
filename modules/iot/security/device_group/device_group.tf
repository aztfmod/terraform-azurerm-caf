# Terraform azurerm resource: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iot_security_device_group

resource "azurecaf_name" "iot_security_device_group" {
  name          = var.settings.name
  resource_type = "azurerm_iot_security_device_group"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_iot_security_device_group" "securitydevicegroup" {
  name      = azurecaf_name.iot_security_device_group.result
  iothub_id = var.iothub_id

  dynamic "allow_rule" {
    for_each = lookup(var.settings, "allow_rule", {}) == {} ? [] : [1]
    content {
      connection_to_ips_not_allowed = try(var.settings.allow_rule.connection_to_ips_not_allowed, null)
    }
  }

  dynamic "range_rule" {
    for_each = lookup(var.settings, "range_rules", {})
    content {
      type     = try(range_rule.value.type, null)
      min      = try(range_rule.value.min, null)
      max      = try(range_rule.value.max, null)
      duration = try(range_rule.value.duration, null)
    }
  }
}
