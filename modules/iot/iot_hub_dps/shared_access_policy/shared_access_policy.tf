# Terraform azurerm resource: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub_dps_shared_access_policy

resource "azurecaf_name" "iothub_dps_shared_access_policy" {
  name          = var.settings.name
  resource_type = "azurerm_iothub_dps_shared_access_policy"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_iothub_dps_shared_access_policy" "access_policy" {
  name                = azurecaf_name.iothub_dps_shared_access_policy.result
  resource_group_name = local.resource_group_name
  iothub_dps_name     = var.iot_dps_name

  enrollment_write   = try(var.settings.enrollment_write, null)
  enrollment_read    = try(var.settings.enrollment_read, null)
  registration_read  = try(var.settings.registration_read, null)
  registration_write = try(var.settings.registration_write, null)
  service_config     = try(var.settings.service_config, null)
}
