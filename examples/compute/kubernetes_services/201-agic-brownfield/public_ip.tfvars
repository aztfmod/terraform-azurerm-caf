public_ip_addresses = {

  agw = {
    name                    = "agw"
    resource_group_key      = "aks_re1"
    sku                     = "Standard"
    allocation_method       = "Static"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"
  }

}
