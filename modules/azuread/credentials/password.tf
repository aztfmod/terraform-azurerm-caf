
resource "azuread_application_password" "key" {
  count       = try(var.settings.azuread_application, null) != null && lower(var.settings.type) == "password" && try(var.settings.azuread_credential_policy_key, null) == null ? 1 : 0
  description = try(var.settings.description, local.description.key)
  value       = random_password.key.0.result
  end_date    = local.expiration_date.key

  application_object_id = try(var.resources.application.id, null)

  lifecycle {
    create_before_destroy = true
    # ignore_changes        = [application_object_id]
  }
}

resource "azuread_application_password" "key0" {
  count       = try(var.settings.azuread_application, null) != null && lower(var.settings.type) == "password" && try(var.settings.azuread_credential_policy_key, null) != null ? 1 : 0
  description = try(var.settings.description, local.description.key0)
  value       = random_password.key0.0.result
  end_date    = local.expiration_date.key0

  application_object_id = try(var.resources.application.id, null)

  lifecycle {
    create_before_destroy = true
    # ignore_changes        = [application_object_id]
  }
}

resource "azuread_application_password" "key1" {
  count       = try(var.settings.azuread_application, null) != null && lower(var.settings.type) == "password" && try(var.settings.azuread_credential_policy_key, null) != null ? 1 : 0
  description = try(var.settings.description, local.description.key1)
  value       = random_password.key1.0.result
  end_date    = local.expiration_date.key1

  application_object_id = try(var.resources.application.id, null)

  lifecycle {
    create_before_destroy = true
    # ignore_changes        = [application_object_id]
  }
}

#
# Everytime the code run it re-evalute the key to store in the keyvault secret
#
locals {
  # Used to set the key with the longest expiring date into the keyvault
  random_key = try(tonumber(formatdate("YYYYMMDDhhmmss", local.expiration_date.key0)) > tonumber(formatdate("YYYYMMDDhhmmss", local.expiration_date.key1)) ? "key0" : "key1", "key")
}

resource "time_sleep" "wait_new_password_propagation" {
  depends_on = [azuread_application_password.key, azuread_application_password.key0, azuread_application_password.key1]

  # 2 mins timer on creation
  create_duration = "2m"

  # 15 mins to allow new password to be propagated in directory partitions when password changes
  destroy_duration = "15m"

  triggers = {
    key  = try(time_rotating.key.0.rotation_rfc3339, null)
    key0 = try(time_rotating.key0.0.rotation_rfc3339, null)
    key1 = try(time_rotating.key1.0.rotation_rfc3339, null)
  }
}

resource "azurerm_key_vault_secret" "client_secret" {
  for_each = {
    for key, value in try(var.settings.keyvaults, {}) : key => value
    if try(var.settings.azuread_application, null) != null && lower(local.password_type) == "password"
  }

  # Add a timer to make sure the new password got replicated into azure ad replica set before we store it into keyvault
  depends_on = [time_sleep.wait_new_password_propagation]

  name            = format("%s-client-secret", each.value.secret_prefix)
  value           = local.random_key == "key0" ? sensitive(azuread_application_password.key0.0.value) : try(sensitive(azuread_application_password.key1.0.value), sensitive(azuread_application_password.key.0.value))
  key_vault_id    = try(each.value.lz_key, null) == null ? var.keyvaults[var.client_config.landingzone_key][each.key].id : var.keyvaults[each.value.lz_key][each.key].id
  expiration_date = local.random_key == "key0" ? local.expiration_date.key0 : try(local.expiration_date.key1, local.expiration_date.key)

  tags = {
    key = local.random_key
  }
}