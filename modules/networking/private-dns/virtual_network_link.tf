

data "terraform_remote_state" "vnet_links" {
  for_each = {
    for key, vnet_link in var.vnet_links : key => vnet_link
    if try(vnet_link.tfstate_key, null) != null
  }

  backend = "azurerm"
  config = {
    storage_account_name = var.tfstates[each.value.tfstate_key].storage_account_name
    container_name       = var.tfstates[each.value.tfstate_key].container_name
    resource_group_name  = var.tfstates[each.value.tfstate_key].resource_group_name
    key                  = var.tfstates[each.value.tfstate_key].key
    use_msi              = var.use_msi
    subscription_id      = var.use_msi ? var.tfstates[each.value.tfstate_key].subscription_id : null
    tenant_id            = var.use_msi ? var.tfstates[each.value.tfstate_key].tenant_id : null
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnet_links" {
  for_each              = var.vnet_links

  name                  = each.value.name
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns.name
  virtual_network_id    = try(var.vnets[each.value.vnet_key].id, data.terraform_remote_state.vnet_links[each.key].outputs[each.value.output_key][each.value.lz_key][each.value.vnet_key].id)
}