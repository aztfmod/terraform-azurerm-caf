locals {
  app_config_id = join("/", concat(
    [""],
    slice(split("/", var.app_config_id), 1, 4),
    [lower(split("/", var.app_config_id)[4])],
    slice(split("/", var.app_config_id), 5, 8),
    [lower(split("/", var.app_config_id)[8])]
  ))
}

resource "azurerm_app_configuration_key" "config" {
  for_each = var.config_settings

  configuration_store_id = local.app_config_id
  key                    = each.value.key
  content_type           = try(each.value.content_type, null)
  label                  = try(each.value.label, null)
  # if value is a keyvault reference, set the correct type, set value to null and set vault_key_reference
  type                = try(each.value.vault_key, null) == null ? "kv" : "vault"
  value               = try(each.value.vault_key, null) == null ? each.value.value : null
  vault_key_reference = try(each.value.vault_key, null) == null ? null : "${var.keyvaults[try(each.value.vault_key.keyvault.lz_key, var.client_config.landingzone_key)][each.value.vault_key.keyvault.key].vault_uri}secrets/${each.value.vault_key.secret_name}"
}
