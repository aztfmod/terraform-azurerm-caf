module "private_endpoint" {
  source   = "../../../networking/private_endpoint"
  for_each = var.private_endpoints

  base_tags           = local.tags
  client_config       = var.client_config
  global_settings     = var.global_settings
  location            = var.resource_groups[try(each.value.resource_group.lz_key, var.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  name                = each.value.name
  private_dns         = var.private_dns
  resource_group_name = var.resource_groups[try(each.value.resource_group.lz_key, var.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].name
  resource_id         = azurerm_batch_account.account.id
  settings            = each.value
  subnet_id           = can(each.value.subnet_id) ? each.value.subnet_id : var.vnets[try(each.value.lz_key, var.client_config.landingzone_key)][each.value.vnet_key].subnets[each.value.subnet_key].id
}
