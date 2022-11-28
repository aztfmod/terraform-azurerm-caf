
vnets = {
  vnet_region1 = {
    region             = "region2"
    resource_group_key = "vm_region1"
    vnet = {
      name          = "virtual_machines"
      address_space = ["10.100.102.0/24"]
      dns_servers   = ["10.100.100.4"]
    }
    subnets = {
      wvd_hosts = {
        name = "wvd_hosts"
        cidr = ["10.100.102.0/29"]
      }
    }

  }
}

vnet_peerings = {
  #
  # Peering Region1
  #
  vnet_region1_TO_hub = {
    name = "vnet_region1_TO_hub"
    from = {
      vnet_key = "vnet_region1"
    }
    to = {
      remote_virtual_network_id = "/subscriptions/sub-id/resourceGroups/xviq-rg-example-virtual-machine-rg1/providers/Microsoft.Network/virtualNetworks/xviq-vnet-virtual_machines"
    }
    allow_virtual_network_access = true
    allow_forwarded_traffic      = false
    allow_gateway_transit        = false
    use_remote_gateways          = false
  }

  hub_TO_vnet_region1 = {
    name = "hub_TO_vnet_region1"
    from = {
      virtual_network_name = "xviq-vnet-virtual_machines"
      resource_group_name  = "xviq-rg-example-virtual-machine-rg1"
    }
    to = {
      vnet_key = "vnet_region1"
    }
    allow_virtual_network_access = true
    allow_forwarded_traffic      = true
    allow_gateway_transit        = true
    use_remote_gateways          = false
  }

}