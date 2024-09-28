resource "azurerm_container_app_environment_certificate" "caec" {
  name                         = var.settings.name
  container_app_environment_id = var.container_app_environment_id
  certificate_blob_base64      = var.settings.certificate_blob_base64
  certificate_password         = var.settings.certificate_password
  tags                         = merge(local.tags, try(var.settings.tags, null))
}
