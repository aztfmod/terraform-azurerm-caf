module "private_endpoint" {
  source   = "../../networking/private_endpoint"
  for_each = var.remote_objects.private_endpoints

  resource_id     = azurerm_data_factory.df.id
  name            = each.value.name
  resource_groups = var.resource_groups
  subnet_id       = try(var.remote_objects.vnets[var.client_config.landingzone_key][each.value.vnet_key].subnets[each.value.subnet_key].id, var.remote_objects.vnets[each.value.lz_key][each.value.vnet_key].subnets[each.value.subnet_key].id)
  settings        = each.value
  global_settings = var.global_settings
  base_tags       = var.base_tags
  private_dns     = var.remote_objects.private_dns
  client_config   = var.client_config
}