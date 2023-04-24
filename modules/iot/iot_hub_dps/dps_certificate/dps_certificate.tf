# Terraform azurerm resource: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub_dps_certificate

resource "azurecaf_name" "iothub_dps_certificate" {
  name          = var.settings.name
  resource_type = "azurerm_iothub_dps_certificate"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_iothub_dps_certificate" "certificate" {
  name                = azurecaf_name.iothub_dps_certificate.result
  resource_group_name = local.resource_group_name
  iot_dps_name        = var.iot_dps_name
  certificate_content = filebase64(format("%s/%s", path.cwd, var.settings.certificate_content))
}
