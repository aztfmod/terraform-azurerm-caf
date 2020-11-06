resource "azurerm_database_migration_service" "dms" {
  for_each = var.settings.dms

  name                = each.value.name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id
  sku_name            = each.value.sku_name
  tags                = try(var.settings.tags, {})
}