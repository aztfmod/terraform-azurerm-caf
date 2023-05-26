# Terraform azurerm resource: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub_certificate

resource "azurecaf_name" "iothub_certificate" {
  name          = var.settings.name
  resource_type = "azurerm_iothub_certificate"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_iothub_certificate" "certificate" {
  name                = azurecaf_name.iothub_certificate.result
  resource_group_name = local.resource_group_name
  iothub_name         = var.iothub_name
  is_verified         = try(var.settings.is_verified, null)
  certificate_content = try(
    replace(replace(replace(data.azurerm_key_vault_secret.certificate["enabled"].value, "-----BEGIN CERTIFICATE-----", ""), "-----END CERTIFICATE-----", ""), "\n", ""),
    filebase64(format("%s/%s", path.cwd, var.settings.certificate_content))
  )
}

data "azurerm_key_vault_secret" "certificate" {
  for_each = try(var.settings.keyvault_secret, null) != null ? toset(["enabled"]) : toset([])
  name     = var.settings.keyvault_secret.secret_name
  key_vault_id = try(
    var.settings.keyvault_secret.key_vault_id,
    var.keyvaults[try(var.settings.keyvault_secret.lz_key, var.client_config.landingzone_key)][var.settings.keyvault_secret.keyvault_key].id,
  )
}
