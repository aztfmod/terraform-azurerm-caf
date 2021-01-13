public_ip_addresses = {
  jump_host_pip1 = {
    name                    = "jump_host_pip1"
    resource_group_key      = "network"
    sku                     = "Standard"
    allocation_method       = "Static"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"
  }

  web_pip1 = {
    name                    = "web_pip1"
    resource_group_key      = "network"
    sku                     = "Standard"
    allocation_method       = "Static"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"
  }
}