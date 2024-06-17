module "cognitive_services_account" {
  source = "../private_endpoint"
  for_each = {
    for key, value in try(var.private_endpoints.cognitive_services_account, {}) : key => value
    if can(value.lz_key) == false
  }
  global_settings     = var.global_settings
  client_config       = var.client_config
  settings            = each.value
  resource_id         = can(each.value.resource_id) ? each.value.resource_id : var.remote_objects.cognitive_services_accounts[var.client_config.landingzone_key][try(each.value.key, each.key)].id
  subresource_names   = toset(try(each.value.private_service_connection.subresource_names, ["account"]))
  subnet_id           = var.subnet_id
  private_dns         = var.private_dns
  name                = try(each.value.name, each.key)
  resource_group_name = can(each.value.resource_group_key) ? var.resource_groups[try(each.value.lz_key, var.client_config.landingzone_key)][each.value.resource_group_key].name : var.vnet_resource_group_name
  location            = var.vnet_location # The private endpoint must be deployed in the same region as the virtual network.
  base_tags           = var.base_tags
}
module "cognitive_services_account_remote" {
  source = "../private_endpoint"
  for_each = {
    for key, value in try(var.private_endpoints.cognitive_services_account, {}) : key => value
    if can(value.lz_key)
  }
  global_settings     = var.global_settings
  client_config       = var.client_config
  settings            = each.value
  resource_id         = can(each.value.key) ? var.remote_objects.cognitive_services_accounts[each.value.lz_key][each.value.key].id : var.remote_objects.cognitive_services_accounts[each.value.lz_key][each.key].id
  subresource_names   = toset(try(each.value.private_service_connection.subresource_names, ["account"]))
  subnet_id           = var.subnet_id
  private_dns         = var.private_dns
  name                = try(each.value.name, each.key)
  resource_group_name = can(each.value.resource_group_key) ? var.resource_groups[try(each.value.lz_key, var.client_config.landingzone_key)][each.value.resource_group_key].name : var.vnet_resource_group_name
  location            = var.vnet_location # The private endpoint must be deployed in the same region as the virtual network.
  base_tags           = var.base_tags
}