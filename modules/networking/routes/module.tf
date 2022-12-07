resource "azurerm_route" "route" {
  name                   = var.name
  resource_group_name    = var.resource_group_name
  route_table_name       = var.route_table_name
  address_prefix         = var.address_prefix
  next_hop_type          = var.next_hop_type
  next_hop_in_ip_address = try(lower(var.next_hop_type), null) == "virtualappliance" ? coalesce(var.next_hop_in_ip_address, var.next_hop_in_ip_address_fw, var.next_hop_in_ip_address_vm) : null
}
