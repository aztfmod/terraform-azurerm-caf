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
  resource_group_name = var.resource_group_name
  iothub_name         = var.iothub_name
  is_verified         = try(var.settings.is_verified, null)
  certificate_content = filebase64( var.settings.certificate_content )
}
