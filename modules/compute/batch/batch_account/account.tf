resource "azurecaf_name" "account" {
  name          = var.settings.name
  resource_type = "azurerm_batch_account"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_batch_account" "account" {
  name                          = azurecaf_name.account.result
  resource_group_name           = var.resource_group_name
  location                      = var.location
  pool_allocation_mode          = try(var.settings.pool_allocation_mode, null)
  public_network_access_enabled = try(var.settings.public_network_access_enabled, null)
  storage_account_id            = var.storage_account_id
  tags                          = local.tags

  dynamic "identity" {
    for_each = try(var.settings.identity, null) != null ? [var.settings.identity] : []

    content {
      type         = identity.value.type
      identity_ids = local.managed_identities
    }
  }

  dynamic "key_vault_reference" {
    for_each = try(var.keyvault, null) != null ? [var.keyvault] : []

    content {
      id  = key_vault_reference.value.id
      url = key_vault_reference.value.vault_uri
    }
  }

  # introduced in azurerm 2.99.0
  # dynamic "encryption" {
  #   for_each = try(var.key_vault_key_id, null) != null ? [var.key_vault_key_id] : []

  #   content {
  #     key_vault_key_id = encryption.value
  #   }
  # }
}
