module "keyvault" {
  source   = "../private_endpoint"
  for_each = try(var.private_endpoints.keyvaults, {})

  global_settings     = var.global_settings
  client_config       = var.client_config
  settings            = each.value
  resource_id         = try(var.remote_objects.keyvaults[each.value.lz_key][each.key].id, var.remote_objects.keyvaults[var.client_config.landingzone_key][each.key].id)
  subresource_names   = ["vault"]
  subnet_id           = var.subnet_id
  private_dns         = var.private_dns
  name                = try(each.value.name, each.key)
  resource_group_name = try(var.resource_groups[each.value.resource_group_key].name, var.vnet_resource_group_name)
  location            = var.vnet_location # The private endpoint must be deployed in the same region as the virtual network.
  base_tags           = var.base_tags
}