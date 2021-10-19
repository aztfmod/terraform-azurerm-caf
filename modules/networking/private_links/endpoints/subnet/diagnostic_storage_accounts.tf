module "diagnostic_storage_account" {
  source              = "../private_endpoint"
  for_each            = try(var.private_endpoints.diagnostic_storage_accounts, {})
  base_tags           = var.base_tags
  client_config       = var.client_config
  global_settings     = var.global_settings
  location            = var.vnet_location # The private endpoint must be deployed in the same region as the virtual network.
  name                = try(each.value.name, each.key)
  private_dns         = var.private_dns
  resource_group_name = try(var.resource_groups[each.value.resource_group_key].name, var.vnet_resource_group_name)
  resource_id         = can(each.value.resource_id) ? each.value.resource_id : var.remote_objects.diagnostic_storage_accounts[each.key].id
  settings            = each.value
  subnet_id           = var.subnet_id
  subresource_names   = toset(try(each.value.private_service_connection.subresource_names, ["blob"]))
}