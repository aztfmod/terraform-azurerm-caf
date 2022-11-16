resource "azurerm_batch_certificate" "certificate" {
  account_name         = var.batch_account.name
  resource_group_name  = var.batch_account.resource_group_name
  certificate          = var.certificate
  format               = var.settings.format
  password             = try(var.settings.password, null)
  thumbprint           = var.settings.thumbprint
  thumbprint_algorithm = var.settings.thumbprint_algorithm
}
