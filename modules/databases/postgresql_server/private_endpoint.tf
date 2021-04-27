module "private_endpoint" {
  source   = "../../networking/private_endpoint"
  for_each = try(var.private_endpoints, {})

  resource_id         = azurerm_postgresql_server.postgresql.id
  name                = each.value.name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id
  settings            = each.value
  global_settings     = var.global_settings
  base_tags           = local.tags
  private_dns         = var.private_dns
  client_config       = var.client_config
}