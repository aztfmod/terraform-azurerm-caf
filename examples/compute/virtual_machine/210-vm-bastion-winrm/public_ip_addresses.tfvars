
public_ip_addresses = {
  bastion_host_pip1 = {
    name                    = "bastion_host_pip1"
    resource_group_key      = "vm_region1"
    sku                     = "Standard"
    allocation_method       = "Static"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"

  }
}