module "private_endpoint" {
  source   = "../../networking/private_endpoint"
  for_each = try(var.private_endpoints, {})

  resource_id = azurerm_postgresql_server.postgresql.id
  name        = each.value.name
  location    = var.location
  #resource_group_name = var.resource_group_name
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : var.resource_groups[try(each.value.resource_group.lz_key, var.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  subnet_id           = var.subnet_id
  settings            = each.value
  global_settings     = var.global_settings
  base_tags           = local.tags
  private_dns         = var.private_dns
  client_config       = var.client_config
}