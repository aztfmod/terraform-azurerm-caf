global_settings = {
  default_region = "region1"
  regions = {
    region1 = "northeurope"
  }
}

resource_groups = {
  test = {
    name = "test"
  }
}

vnets = {
  vnet1 = {
    resource_group_key = "test"
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

public_ip_addresses = {
  pip1 = {
    name               = "pip1-name"
    resource_group_key = "test"
    sku                = "Standard" # must be 'Standard' SKU
    # Standard SKU Public IP Addresses that do not specify a zone are zone redundant by default.
    allocation_method       = "Static"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"
  }
}

azurerm_firewalls = {
  firewall1 = {
    name               = "test-firewall"
    resource_group_key = "test"
    vnet_key           = "vnet1"
    sku_tier           = "Premium"
    zones              = [1, 2, 3]
    public_ips = {
      ip1 = {
        name          = "pip1"
        public_ip_key = "pip1"
        vnet_key      = "vnet1"
        subnet_key    = "AzureFirewallSubnet"
        # lz_key = "lz_key"
      }
      # ip2 = {
      #   name = "pip2"
      #   public_ip_id = "azure_resource_id"
      #   subnet_id = "azure_resource_id"
      # }
    }
  }
}