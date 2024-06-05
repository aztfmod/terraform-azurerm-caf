locals {
  keyvault = local.create_sshkeys || local.os_type == "windows" || try(var.settings.virtual_machine_settings[local.os_type].admin_password_key, var.settings.virtual_machine_settings[local.os_type].admin_username_key, null) != null ? var.keyvaults[try(var.settings.keyvault.lz_key, var.settings.lz_key, var.client_config.landingzone_key)][try(var.settings.keyvault.key, var.settings.keyvault_key)] : null

  #
  # Get the admin username and password from keyvault
  #
  admin_username = can(var.settings.virtual_machine_settings[local.os_type].admin_username_key) ? data.external.admin_username.0.result.value : null
  admin_password = can(var.settings.virtual_machine_settings[local.os_type].admin_password_key) ? data.external.admin_password.0.result.value : null
}

#
# Use data external to retrieve value from different subscription
#
# With for_each it is not possible to change the provider's subscription at runtime so using the following pattern.
#
data "external" "admin_username" {
  count = try(var.settings.virtual_machine_settings[local.os_type].admin_username_key, null) == null ? 0 : 1
  program = [
    "bash", "-c",
    format(
      "az keyvault secret show --name '%s' --vault-name '%s' --query '{value: value }' -o json",
      var.settings.virtual_machine_settings[local.os_type].admin_username_key,
      local.keyvault.name
    )
  ]
}

data "external" "admin_password" {
  count = try(var.settings.virtual_machine_settings[local.os_type].admin_password_key, null) == null ? 0 : 1
  program = [
    "bash", "-c",
    format(
      "az keyvault secret show -n '%s' --vault-name '%s' --query '{value: value }' -o json",
      var.settings.virtual_machine_settings[local.os_type].admin_password_key,
      local.keyvault.name
    )
  ]
}
