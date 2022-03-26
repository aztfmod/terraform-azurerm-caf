resource "azurerm_virtual_machine_extension" "keyvault_for_windows" {
  for_each = var.extension_name == "keyvault_for_windows" ? toset(["enabled"]) : toset([])

  name                       = "keyvault_for_windows"
  virtual_machine_id         = var.virtual_machine_id
  publisher                  = "Microsoft.Azure.KeyVault"
  type                       = "KeyVaultForWindows"
  type_handler_version       = try(var.extension.type_handler_version, "1.0")
  auto_upgrade_minor_version = try(var.extension.auto_upgrade_minor_version, true)

  settings = jsonencode(
    {
      "secretsManagementSettings" : {
        "pollingIntervalInS" : try(var.extension.polling_interval_in_s, "3600")
        "linkOnRenewal" : try(var.extension.link_on_renewal, false)
        "requireInitialSync" : try(var.extension.require_initial_sync, true)
        "certificateStoreName" : try(var.extension.certificate_store_name, "My")
        "certificateStoreLocation" : try(var.extension.certificate_store_location, "LocalMachine")
        "observedCertificates" : local.certificate_ids
      }
    }
  )
}

#TODO:
# ,
#       "authenticationSettings": {
#         "msiEndpoint":  "http://169.254.169.254/metadata/identity/oauth2/token",
#         "msiClientId":  <Optional MSI identity e.g.: "c7373ae5-91c2-4165-8ab6-7381d6e75619">
#       }

# retrive certificates from key vault
data "azurerm_key_vault_certificate" "certificate" {
  for_each = var.extension_name == "keyvault_for_windows" ? tomap(var.extension.certificates) : tomap({})

  name = each.value.name
  key_vault_id = try(
    each.value.key_vault_id,
    var.keyvaults[each.value.lz_key][each.value.keyvault_key].id,
    var.keyvaults[var.client_config.landingzone_key][each.value.keyvault_key].id
  )
}

locals {
  certificate_ids = [for key, value in tomap(data.azurerm_key_vault_certificate.certificate) : value.secret_id]
}