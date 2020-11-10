
resource "azurecaf_name" "pep" {
  name          = var.name
  resource_type = "azurerm_private_endpoint"
  prefixes      = [var.global_settings.prefix]
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
}

resource "azurerm_private_endpoint" "pep" {
  name                = azurecaf_name.pep.result
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id
  tags                = local.tags

  private_service_connection {
    name                           = var.settings.private_service_connection.name
    private_connection_resource_id = var.resource_id
    is_manual_connection           = var.settings.private_service_connection.is_manual_connection
    subresource_names              = try(var.settings.private_service_connection.subresource_names, [])
    request_message                = try(var.settings.private_service_connection.request_message, null)
  }
}