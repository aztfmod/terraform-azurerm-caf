## Networking configuration
vnets = {
  asrr_network_region1 = {
    resource_group_key = "primary"

    vnet = {
      name          = "asrr-vnet-primary"
      address_space = ["192.168.1.0/24"]

    }
    #specialsubnets = {}
    subnets = {
      asrr_subnet = {
        name        = "asrr-primary-subnet"
        cidr        = ["192.168.1.0/24"]
        # enforce_private_link_endpoint_network_policies = "true"

      }
    }

  }
  asrr_network_region2 = {
    resource_group_key = "secondary"

    vnet = {
      name          = "asrr-vnet-secondary"
      address_space = ["192.168.1.0/24"]

    }
    #specialsubnets = {}
    subnets = {
      asrr_subnet = {
        name        = "asrr-secondary-subnet"
        cidr        = ["192.168.1.0/24"]
        # enforce_private_link_endpoint_network_policies = "true"

      }
    }

  }
}

public_ip_addresses = {
  public_ip_primary = {
    name                    = "public-ip-primary"
    resource_group_key      = "primary"
    sku                     = "Basic"
    # Note: For UltraPerformance ExpressRoute Virtual Network gateway, the associated Public IP needs to be sku "Basic" not "Standard"
    allocation_method = "Static"
    # allocation method needs to be Dynamic
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"
  }
  public_ip_secondary = {
    name                    = "public-ip-secondary"
    resource_group_key      = "secondary"
    sku                     = "Basic"
    # Note: For UltraPerformance ExpressRoute Virtual Network gateway, the associated Public IP needs to be sku "Basic" not "Standard"
    allocation_method = "Static"
    # allocation method needs to be Dynamic
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"
  }
}