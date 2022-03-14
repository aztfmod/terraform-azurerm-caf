global_settings = {
  default_region = "region1"
  regions = {
    region1 = "eastus2"
  }
}

resource_groups = {
  hub_re1 = {
    name   = "vnet-hub-re1"
    region = "region1"
  }
}

virtual_wans = {
  vwan_re1 = {
    resource_group_key = "hub_re1"
    name               = "contosovWAN-re1"
    region             = "region1"

    hubs = {
      hub_re1 = {
        hub_name           = "hub-re1"
        region             = "region1"
        hub_address_prefix = "10.0.3.0/24"
        deploy_firewall    = false
        deploy_p2s         = false
        p2s_config         = {}
        deploy_s2s         = false
        s2s_config         = {}
        deploy_er          = false
        er_config          = {}

      }
    }
  }
}


azurerm_firewalls = {
  firewall1 = {
    name               = "test-firewall"
    sku_name           = "AZFW_Hub"
    sku_tier           = "Premium"
    resource_group_key = "hub_re1"
    vnet_key           = "vnet1"
    virtual_hub = {
      hub1 = {
        virtual_wan_key = "vwan_re1"
        virtual_hub_key = "hub_re1"
        #virtual_hub_id = "Azure_resource_id"
        #lz_key = "lz_key"
        public_ip_count = 1
      }
    }
  }
}

vnets = {
  vnet1 = {
    resource_group_key = "hub_re1"
    vnet = {
      name          = "test-vn"
      address_space = ["10.2.0.0/16"]
    }
    specialsubnets = {
      AzureFirewallSubnet = {
        name = "AzureFirewallSubnet" # must be named AzureFirewallSubnet
        cidr = ["10.2.1.0/24"]
      }
    }
    subnets = {}
  }
}