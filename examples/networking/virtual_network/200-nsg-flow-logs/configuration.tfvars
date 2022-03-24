global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
    region2 = "australiacentral"
  }
}

resource_groups = {
  vnet_hub_re1 = {
    name   = "vnet-hub-re1"
    region = "region1"
  }
}

vnets = {
  hub_re1 = {
    resource_group_key = "vnet_hub_re1"
    region             = "region1"
    vnet = {
      name          = "hub-re1"
      address_space = ["100.64.92.0/22"]
    }
    specialsubnets = {
      GatewaySubnet = {
        name = "GatewaySubnet" #Must be called GateWaySubnet in order to host a Virtual Network Gateway
        cidr = ["100.64.92.0/27"]
      }
      AzureFirewallSubnet = {
        name = "AzureFirewallSubnet" #Must be called AzureFirewallSubnet
        cidr = ["100.64.93.0/26"]
      }
    }
    subnets = {
      AzureBastionSubnet = {
        name    = "AzureBastionSubnet" #Must be called AzureBastionSubnet
        cidr    = ["100.64.93.64/26"]
        nsg_key = "azure_bastion_nsg"
      }
      jumpbox = {
        name    = "jumpbox"
        cidr    = ["100.64.94.0/27"]
        nsg_key = "jumpbox"
      }
      private_endpoints = {
        name                                           = "private_endpoints"
        cidr                                           = ["100.64.95.128/25"]
        enforce_private_link_endpoint_network_policies = true
        nsg_key                                        = "empty_nsg"
      }
    }

    # you can setup up to 5 keys - vnet diganostic
    diagnostic_profiles = {
      central_logs_region1 = {
        definition_key   = "networking_all"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }

  }
}

public_ip_addresses = {

  bastion_host_rg1 = {
    name                    = "bastion-rg1-pip1"
    region                  = "region1"
    resource_group_key      = "vnet_hub_re1"
    sku                     = "Standard"
    allocation_method       = "Static"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"

    # you can setup up to 5 key
    diagnostic_profiles = {
      central_logs_region1 = {
        definition_key   = "public_ip_address"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }
  }

}


bastion_hosts = {
  bastion_hub_re1 = {
    name               = "bastion-rg1"
    region             = "region1"
    resource_group_key = "vnet_hub_re1"
    vnet_key           = "hub_re1"
    subnet_key         = "AzureBastionSubnet"
    public_ip_key      = "bastion_host_rg1"

    # you can setup up to 5 profiles
    diagnostic_profiles = {
      central_logs_region1 = {
        definition_key   = "bastion_host"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }
  }

}