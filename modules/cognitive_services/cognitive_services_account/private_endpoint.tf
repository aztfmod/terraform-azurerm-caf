#
# Private endpoint
#

module "private_endpoint" {
  source   = "../../../modules/networking/private_endpoint/"
  for_each = var.private_endpoints

  resource_id         = azurerm_cognitive_account.service.id
  name                = each.value.name
  location            = local.location
  resource_group_name = local.resource_group_name
  #subnet_id           = can(each.value.subnet_id) ? each.value.subnet_id : var.remote_objects.vnets[try(each.value.lz_key, var.client_config.landingzone_key)][each.value.vnet_key].subnets[each.value.subnet_key].id
  subnet_id = can(each.value.subnet_id) || can(each.value.subnet_key) ? try(each.value.subnet_id, var.remote_objects.virtual_subnets[try(each.value.lz_key, var.client_config.landingzone_key)][each.value.subnet_key].id) : var.remote_objects.vnets[try(each.value.lz_key, var.client_config.landingzone_key)][each.value.vnet_key].subnets[each.value.subnet_key].id
  settings            = each.value
  global_settings     = var.global_settings
  tags                = local.tags
  base_tags           = var.base_tags
  private_dns         = var.remote_objects.private_dns
  client_config       = var.client_config
}
