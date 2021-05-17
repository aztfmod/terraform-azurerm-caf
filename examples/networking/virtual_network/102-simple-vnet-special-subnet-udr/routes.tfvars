route_tables = {
  no_internet = {
    name               = "no_internet"
    resource_group_key = "network"
  }
  special_rt = {
    name               = "special_subnet_rt"
    resource_group_key = "network"
  }
}

azurerm_routes = {
  no_internet = {
    name               = "no_internet"
    resource_group_key = "network"
    route_table_key    = "no_internet"
    address_prefix     = "0.0.0.0/0"
    next_hop_type      = "None"
  }
  gateway = {
    name               = "special_route"
    resource_group_key = "network"
    route_table_key    = "special_rt"
    address_prefix     = "192.168.1.1/32"
    next_hop_type      = "None"
  }
}