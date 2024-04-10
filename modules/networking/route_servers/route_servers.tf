resource "azurerm_route_server" "route_server" {

  branch_to_branch_traffic_enabled = try(var.settings.branch_to_branch_traffic_enabled, false)
  location                         = var.location
  name                             = var.settings.name
  public_ip_address_id             = try(var.settings.public_ip_address_id, null) != null ? var.settings.public_ip_address_id : (lookup(var.settings.public_ip_address, "lz_key", null) == null ? var.public_ip_addresses[var.client_config.landingzone_key][var.settings.public_ip_address.public_ip_address_key].id : var.public_ip_addresses[var.settings.public_ip_address.lz_key][var.settings.public_ip_address.public_ip_address_key].id)
  resource_group_name              = var.resource_group_name #check
  sku                              = try(var.settings.sku, "Standard")
  subnet_id                        = try(var.settings.subnet_id, null) != null ? var.settings.subnet_id : (lookup(var.settings.subnet, "lz_key", null) == null ? var.virtual_networks[var.client_config.landingzone_key][var.settings.subnet.vnet_key].subnets[var.settings.subnet.subnet_key].id : var.virtual_networks[var.settings.subnet.lz_key][var.settings.subnet.vnet_key].subnets[var.settings.subnet.subnet_key].id)
  tags                             = local.tags
}
