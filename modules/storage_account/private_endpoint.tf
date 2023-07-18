module "private_endpoint" {
  source   = "../networking/private_endpoint"
  for_each = var.private_endpoints

  resource_id         = azurerm_storage_account.stg.id
  name                = each.value.name
  location            = local.location
  resource_group_name = local.resource_group_name
  # if subnet_id is defined and not null, use it.  Otherwise calculate subnet id using vnets collection and provided keys
  subnet_id       = try(each.value.subnet_id, null) != null ? each.value.subnet_id : var.vnets[coalesce(try(each.value.lz_key, null), var.client_config.landingzone_key)][each.value.vnet_key].subnets[each.value.subnet_key].id
  settings        = each.value
  global_settings = var.global_settings
  tags            = local.tags
  base_tags       = var.base_tags
  private_dns     = var.private_dns
  client_config   = var.client_config
}
