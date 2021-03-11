resource "azurerm_network_interface_application_security_group_association" "asg" {
  # for_each = var.settings.networking_interface_asg_associations
  #network_interface_id          = azurerm_network_interface.nic[each.key].id
  network_interface_id = var.network_interface_id
 # subnet_id           = module.networking[each.value.vnet_key].subnets["AzureFirewallSubnet"].id
 # application_security_group_id = lookup(each.value, "application_security_group_key", null) == null ? null : try(var.application_security_groups[var.client_config.landingzone_key][each.value.application_security_group_key].id, var.application_security_groups[each.value.lz_key][each.value.application_security_group_key].id)
  application_security_group_id = var.application_security_group_id
}
