
resource "azurecaf_name" "pep" {
  name          = var.name
  resource_type = "azurerm_private_endpoint"
  prefixes      = [var.global_settings.prefix]
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_private_endpoint" "pep" {
  for_each = toset(try(var.settings.private_service_connection.subresource_names, var.subresource_names))

  name                = format("%s-%s", azurecaf_name.pep.result, each.key)
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id
  tags                = local.tags

  private_service_connection {
    name                           = format("%s-%s", var.settings.private_service_connection.name, each.key)
    private_connection_resource_id = var.resource_id
    is_manual_connection           = try(var.settings.private_service_connection.is_manual_connection, false)
    subresource_names              = [each.key]
    request_message                = try(var.settings.private_service_connection.request_message, null)
  }
}