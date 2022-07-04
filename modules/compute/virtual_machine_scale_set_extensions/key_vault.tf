resource "azurerm_virtual_machine_scale_set_extension" "keyvault" {
  for_each                     = var.extension_name == "microsoft_azure_keyvault" ? toset(["enabled"]) : toset([])
  name                         = "microsoft_azure_keyvault"
  publisher                    = "Microsoft.Azure.KeyVault"
  type                         = "KeyVaultForWindows"
  virtual_machine_scale_set_id = var.virtual_machine_scale_set_id
  type_handler_version         = try(var.extension.type_handler_version, "1.0")
  auto_upgrade_minor_version   = try(var.extension.auto_upgrade_minor_version, true)

  lifecycle {
    ignore_changes = [
      settings,
      protected_settings
    ]
  }

  settings = jsonencode({
    "secretsManagementSettings" : {
      "pollingIntervalInS" : try(var.extension.secretsManagementSettings.pollingIntervalInS, "3600")
      "certificateStoreName" : try(var.extension.secretsManagementSettings.certificateStoreName)
      "linkOnRenewal" : try(var.extension.secretsManagementSettings.linkOnRenewal, false)
      "certificateStoreLocation" : try(var.extension.secretsManagementSettings.certificateStoreLocation, "")
      "requireInitialSync" : try(var.extension.secretsManagementSettings.requireInitialSync, true)
      "observedCertificates" : try(var.extension.secretsManagementSettings.observedCertificates, "")
    }
    "authenticationSettings" : {
      "msiEndpoint" : try(var.extension.authenticationSettings.msiEndpoint, "http://169.254.169.254/metadata/identity")
      "msiClientId" : try(var.extension.authenticationSettings.msiClientId, local.managed_identity_client_id)
    }
  })
}

locals {
  managed_local_identity_client_id  = try(var.managed_identities[var.client_config.landingzone_key][var.extension.managed_identity_key].client_id, "")
  managed_remote_identity_client_id = try(var.managed_identities[var.extension.lz_key][var.extension.managed_identity_key].client_id, "")
  provided_identity_client_id       = try(var.extension.managed_identity_id, "")
  managed_identity_client_id        = try(coalesce(local.managed_local_identity_client_id, local.managed_remote_identity_client_id, local.provided_identity_client_id), "")
}
