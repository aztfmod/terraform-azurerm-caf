module "external_resources" {
  source = "../private_endpoint"
  for_each = {
    for key, value in try(var.private_endpoints.external_resources, {}) : key => value
  }
  global_settings     = var.global_settings
  client_config       = var.client_config
  settings            = each.value
  resource_id         = null
  subresource_names   = ["external_resources"]
  subnet_id           = var.subnet_id
  private_dns         = var.private_dns
  name                = try(each.value.name, each.key)
  resource_group_name = can(each.value.resource_group_key) ? var.resource_groups[try(each.value.lz_key, var.client_config.landingzone_key)][each.value.resource_group_key].name : var.vnet_resource_group_name
  location            = var.vnet_location # The private endpoint must be deployed in the same region as the virtual network.
  base_tags           = var.base_tags
}