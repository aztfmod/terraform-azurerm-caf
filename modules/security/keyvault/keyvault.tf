
resource "azurecaf_naming_convention" "keyvault" {
  name          = var.keyvault.name
  resource_type = "kv"
  convention    = lookup(var.keyvault, "location", var.global_settings.convention)
  prefix        = lookup(var.keyvault, "useprefix", false) == true ? var.global_settings.prefix_start_alpha : ""
  max_length    = lookup(var.keyvault, "max_length", null)
}

resource "azurerm_key_vault" "keyvault" {

  name                            = azurecaf_naming_convention.keyvault.result
  location                        = var.global_settings.regions[ lookup(var.keyvault, "region", var.resource_groups[var.keyvault.resource_group_key].location) ]
  resource_group_name             = var.resource_groups[var.keyvault.resource_group_key].name
  tenant_id                       = var.tenant_id
  sku_name                        = var.keyvault.sku_name
  tags                            = lookup(var.keyvault, "tags", null)
  enabled_for_deployment          = lookup(var.keyvault, "enabled_for_deployment", false)
  enabled_for_disk_encryption     = lookup(var.keyvault, "enabled_for_disk_encryption", false)
  enabled_for_template_deployment = lookup(var.keyvault, "enabled_for_template_deployment", false)
  purge_protection_enabled        = lookup(var.keyvault, "purge_protection_enabled", false)
  soft_delete_enabled             = lookup(var.keyvault, "soft_delete_enabled", false)

  # access_policy {
  #   tenant_id = data.azurerm_client_config.current.tenant_id
  #   object_id = var.logged_user_objectId

  #   key_permissions    = []
  #   secret_permissions = ["Get", "List", "Set", "Delete"]
  # }

  # dynamic "network_acls" {
  #   for_each = lookup(var.keyvault, "network_acls", false) == false ? [] : [1]

  #   content {
  #     default_action                = lookup(var.keyvault.network_acls, "default_action", "Deny")
  #     bypass                        = lookup(var.keyvault.network_acls, "bypass", "None")
  #     ip_rules                      = lookup(var.keyvault.network_acls, "ip_rules", null)
  #     virtual_network_subnet_ids    = lookup(var.keyvault.network_acls, "default_action", null)
  #   }
  # }

}

