vnets = {
  hub_re1 = {
    resource_group_key = "vnet_hub_re1"
    region             = "region1"
    vnet = {
      name          = "hub-re1"
      address_space = ["100.64.92.0/22"]
    }
    subnets = {
      AzureBastionSubnet = {
        name    = "AzureBastionSubnet" #Must be called AzureBastionSubnet
        cidr    = ["100.64.93.64/26"]
        nsg_key = "azure_bastion_nsg"
      }
      vm = {
        name    = "vm"
        cidr    = ["100.64.94.0/27"]
        nsg_key = "jumpbox"
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