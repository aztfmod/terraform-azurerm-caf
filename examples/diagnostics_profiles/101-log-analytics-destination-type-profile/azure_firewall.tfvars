
azurerm_firewalls = {
  demo_fw = {
    name               = "demo-firewall-fw1"
    resource_group_key = "ops"
    vnet_key           = "fw_net"
    sku_tier           = "Premium"
    zones              = [1, 2, 3]

    public_ips = {
      ip1 = {
        name          = "pip1"
        public_ip_key = "fw_pip1"
        vnet_key      = "demo_vnet"
        subnet_key    = "azure_firewall_subnet"
      }
    }

    diagnostic_profiles = {
      p1 = {
        name             = "operational_logs"
        definition_key   = "azure_firewall"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
        # Here the log_analytics_destination type is set.
        log_analytics_destination_type = "Dedicated"
      }
      p2 = {
        name             = "archive_logs"
        definition_key   = "azure_firewall"
        destination_type = "storage"
        destination_key  = "central_logs"
      }
    }
  }
}

vnets = {
  demo_vnet = {
    resource_group_key = "ops"
    vnet = {
      name          = "demo"
      address_space = ["10.0.10.0/24"]
    }
    specialsubnets = {
      azure_firewall_subnet = {
        name = "AzureFirewallSubnet"
        cidr = ["10.0.10.0/26"]
      }
    }
    diagnostic_profiles = {
      p1 = {
        name             = "operational_logs"
        definition_key   = "networking_all"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
      p2 = {
        name             = "archive_logs"
        definition_key   = "networking_all"
        destination_type = "storage"
        destination_key  = "central_logs"
      }
    }
  }
}



public_ip_addresses = {
  fw_pip1 = {
    name               = "demo-pip1"
    resource_group_key = "ops"
    sku                = "Standard"
    # Standard SKU Public IP Addresses that do not specify a zone are zone redundant by default.
    allocation_method       = "Static"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"

    diagnostic_profiles = {
      p1 = {
        name             = "operational_logs"
        definition_key   = "public_ip_address"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
      p2 = {
        name             = "archive_logs"
        definition_key   = "public_ip_address"
        destination_type = "storage"
        destination_key  = "central_logs"
      }
    }
  }
}
