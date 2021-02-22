resource "azurerm_netapp_volume" "volume" {
  # A volume name must be unique within each capacity pool. It must be at least three characters long. You can use any alphanumeric characters.
  name                = var.settings.name
  resource_group_name = var.resource_group_name
  location            = var.location
  account_name        = var.account_name
  volume_path         = var.settings.volume_path
  pool_name           = var.pool_name
  service_level       = var.service_level
  protocols           = try(var.settings.protocols, [])
  subnet_id           = var.subnet_id
  storage_quota_in_gb = try(var.settings.storage_quota_in_gb, 100)
  #export_policy_rule  # need to be implemented
  tags = var.tags
}
