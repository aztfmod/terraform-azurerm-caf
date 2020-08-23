#
# Bastion host service
# https://www.terraform.io/docs/providers/azurerm/r/bastion_host.html
# 

resource "azurerm_bastion_host" "host" {
  for_each = var.compute.bastion_hosts

  name                = each.value.name
  location            = azurerm_resource_group.rg[each.value.resource_group_key].location
  resource_group_name = azurerm_resource_group.rg[each.value.resource_group_key].name
  tags                = try(each.value.tags, null)

  ip_configuration {
    name                 = each.value.name
    subnet_id            = module.networking[each.value.vnet_key].subnets[each.value.subnet_key].id
    public_ip_address_id = module.public_ip_addresses[each.value.public_ip_key].id
  }
}

module bastion_host_diagnostics {
  source = "./modules/diagnostics"
  for_each = var.compute.bastion_hosts

  resource_id       = azurerm_bastion_host.host[each.key].id
  resource_location = azurerm_resource_group.rg[each.value.resource_group_key].location
  diagnostics       = local.diagnostics
  profiles          = try(each.value.diagnostic_profiles, {})
}
