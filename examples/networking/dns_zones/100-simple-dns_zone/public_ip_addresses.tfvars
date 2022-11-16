public_ip_addresses = {
  example_pip1_re1 = {
    name                    = "example_pip1"
    resource_group_key      = "dns_re1"
    sku                     = "Standard"
    allocation_method       = "Static"
    ip_version              = "IPv4"
    zones                   = ["1"]
    idle_timeout_in_minutes = "4"

  }
}