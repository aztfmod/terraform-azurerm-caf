resource "azurecaf_name" "volume" {
  name          = var.settings.name
  prefixes      = var.global_settings.prefixes
  resource_type = "azurerm_netapp_volume"
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_netapp_volume" "volume" {
  # A volume name must be unique within each capacity pool. It must be at least three characters long. You can use any alphanumeric characters.
  name                = azurecaf_name.volume.result
  resource_group_name = var.resource_group_name
  location            = var.location
  account_name        = var.account_name
  volume_path         = var.settings.volume_path
  pool_name           = var.pool_name
  service_level       = var.service_level
  protocols           = try(var.settings.protocols, [])
  subnet_id           = var.subnet_id
  storage_quota_in_gb = try(var.settings.storage_quota_in_gb, 100)
  dynamic "export_policy_rule" {
    for_each = var.export_policy_rule

    content {

      rule_index          = export_policy_rule.value["rule_index"]
      allowed_clients     = export_policy_rule.value["allowed_clients"]
      protocols_enabled   = try(export_policy_rule.value["protocols_enabled"], {})
      unix_read_only      = try(export_policy_rule.value["unix_read_only"], null)
      unix_read_write     = try(export_policy_rule.value["unix_read_write"], null)
      root_access_enabled = try(export_policy_rule.value["root_access_enabled"], false)
    }
  }
  tags = var.tags
  lifecycle {
    ignore_changes = [resource_group_name, location, name]
  }

}
