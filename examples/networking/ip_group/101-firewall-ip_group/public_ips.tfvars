public_ip_addresses = {
  firewall_re1 = {
    name                    = "egress-pip1"
    resource_group_key      = "hub_re1"
    sku                     = "Standard"
    allocation_method       = "Static"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"

  }

  firewall_pip2_re1 = {
    name                    = "egress-pip2"
    resource_group_key      = "hub_re1"
    sku                     = "Standard"
    allocation_method       = "Static"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"

  }
}
