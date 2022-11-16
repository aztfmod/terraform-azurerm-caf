resource "azurerm_network_interface_application_security_group_association" "assoc" {
  for_each = local.nic_asg

  network_interface_id          = azurerm_network_interface.nic[each.value.nic_key].id
  application_security_group_id = each.value.asg_id
}

locals {
  nic_asg = {
    for nic in flatten(
      [
        for nic_key, nic_value in try(var.settings.networking_interfaces, []) : [
          for asg_key, asg_value in try(nic_value.networking_interface_asg_associations, {}) : {
            nic_key = nic_key
            asg_key = asg_key
            asg_id  = var.application_security_groups[try(asg_value.lz_key, var.client_config.landingzone_key)][asg_value.key].id
          }
        ]
      ]
    ) : format("%s-%s", nic.nic_key, nic.asg_key) => nic
  }
}

output "network_interface_application_security_group_associations" {
  value = azurerm_network_interface_application_security_group_association.assoc
}