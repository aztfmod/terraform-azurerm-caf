resource "azurerm_network_interface_application_security_group_association" "asg" {
  application_security_group_id = var.application_security_group_id
  network_interface_id          = var.network_interface_id
}
