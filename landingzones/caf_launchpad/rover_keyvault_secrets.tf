resource "azurerm_key_vault_secret" "launchpad_blob_name" {
  name         = "launchpad-blob-name"
  value        = var.tf_name
  key_vault_id = module.launchpad.keyvaults[var.launchpad_key_names.keyvault].id
}

resource "azurerm_key_vault_secret" "launchpad_blob_container" {
  for_each = {
    for key in var.launchpad_key_names.tfstates : key => key
  }

  name         = format("launchpad-blob-container-%s", each.value)
  value        = module.launchpad.storage_accounts[each.value].name
  key_vault_id = module.launchpad.keyvaults[var.launchpad_key_names.keyvault].id
}

resource "azurerm_key_vault_secret" "launchpad_name" {
  name         = "launchpad-secret-prefix"
  value        = var.azuread_apps[var.launchpad_key_names.azuread_app].keyvault.secret_prefix
  key_vault_id = module.launchpad.keyvaults[var.launchpad_key_names.keyvault].id
}


resource "azurerm_key_vault_secret" "launchpad_subscription_id" {
  name         = "launchpad-subscription-id"
  value        = data.azurerm_client_config.current.subscription_id
  key_vault_id = module.launchpad.keyvaults[var.launchpad_key_names.keyvault].id
}

# launchpad_light or launchpad
resource "azurerm_key_vault_secret" "launchpad_mode" {
  name         = "launchpad-mode"
  value        = var.launchpad_mode
  key_vault_id = module.launchpad.keyvaults[var.launchpad_key_names.keyvault].id
}

