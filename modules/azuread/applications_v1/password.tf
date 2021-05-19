
resource "azuread_application_password" "key0" {
  count                 = lower(var.settings.password_policy.type) == "password" ? 1 : 0
  application_object_id = azuread_application.app.id
  description           = try(var.settings.password_policy.description, local.description.key0)
  value                 = random_password.key0.result
  end_date              = local.expiration_date.key0

  lifecycle {
    create_before_destroy = true
  }
}

resource "azuread_application_password" "key1" {
  count                 = lower(var.settings.password_policy.type) == "password" ? 1 : 0
  application_object_id = azuread_application.app.id
  description           = try(var.settings.password_policy.description, local.description.key1)
  value                 = random_password.key1.result
  end_date              = local.expiration_date.key1

  lifecycle {
    create_before_destroy = true
  }
}

# 
# Everytime the code run it re-evalute the key to store in the keyvault secret
#
locals {
  # Used to set the key with the longest expiring date into the keyvault
  random_key = tonumber(formatdate("YYYYMMDDhhmmss", local.expiration_date.key0)) > tonumber(formatdate("YYYYMMDDhhmmss", local.expiration_date.key1)) ? "key0" : "key1"
}

resource "azurerm_key_vault_secret" "client_secret" {
  for_each        = {
    for key, value in try(var.settings.keyvaults, {}) : key => value
    if lower(var.settings.password_policy.type) == "password"
  }
  name            = format("%s-client-secret", each.value.secret_prefix)
  value           = local.random_key == "key0" ? sensitive(azuread_application_password.key0.0.value) : sensitive(azuread_application_password.key1.0.value)
  key_vault_id    = try(each.value.lz_key, null) == null ? var.keyvaults[var.client_config.landingzone_key][each.key].id : var.keyvaults[each.value.lz_key][each.key].id
  expiration_date = local.random_key == "key0" ? local.expiration_date.key0 : local.expiration_date.key1

  tags = {
    key = local.random_key == "key0" ? "key0" : "key1"
  }
}