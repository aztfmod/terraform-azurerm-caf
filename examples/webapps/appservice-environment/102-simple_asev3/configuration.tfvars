global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  ase_region1 = {
    name   = "ase"
    region = "region1"
  }
  asp_project1_region1 = {
    name   = "asp-project1"
    region = "region1"
  }
  asp_project2_region1 = {
    name   = "asp-project2"
    region = "region1"
  }
  networking_region1 = {
    name   = "ase-networking"
    region = "region1"
  }
}

app_service_environments_v3 = {
  ase1 = {
    resource_group_key        = "ase_region1"
    name                      = "ase01"
    vnet_key                  = "ase_region1"
    subnet_key                = "ase1"
    internalLoadBalancingMode = "Web, Publishing"
  }
}

app_service_plans = {
  asp1 = {
    app_service_environment_key = "ase1"
    resource_group_key          = "asp_project1_region1"

    name = "ase1-asp01"
    kind = "Windows"

    sku = {
      tier             = "IsolatedV2"
      size             = "I1v2"
      capacity         = "1"
      per_site_scaling = true
    }
  },
  asp2 = {
    app_service_environment_key = "ase1"
    resource_group_key          = "asp_project2_region1"

    name = "ase1-asp02"
    kind = "Linux"

    //When creating a Linux App Service Plan, the reserved field must be set to true
    reserved = true

    sku = {
      tier             = "IsolatedV2"
      size             = "I1v2"
      capacity         = "1"
      per_site_scaling = true
    }
  }
}

vnets = {
  ase_region1 = {
    resource_group_key = "networking_region1"
    vnet = {
      name          = "ase"
      address_space = ["172.25.88.0/21"]
    }
    specialsubnets = {}
    subnets = {
      ase1 = {
        name              = "ase1"
        cidr              = ["172.25.92.0/25"]
        service_endpoints = ["Microsoft.Sql"]
        nsg_key           = "ase"
        delegation = {
          name               = "Microsoft.Web.hostingEnvironments"
          service_delegation = "Microsoft.Web/hostingEnvironments"
          action             = ["Microsoft.Network/virtualNetworks/subnets/action"]
        }
      }
      ase2 = {
        name              = "ase2"
        cidr              = ["172.25.92.128/25"]
        service_endpoints = ["Microsoft.Sql"]
        nsg_key           = "ase"
        delegation = {
          name               = "Microsoft.Web.hostingEnvironments"
          service_delegation = "Microsoft.Web/hostingEnvironments"
          action             = ["Microsoft.Network/virtualNetworks/subnets/action"]
        }
      }
      ase3 = {
        name              = "ase3"
        cidr              = ["172.25.93.0/25"]
        service_endpoints = ["Microsoft.Sql"]
        nsg_key           = "ase"
        delegation = {
          name               = "Microsoft.Web.hostingEnvironments"
          service_delegation = "Microsoft.Web/hostingEnvironments"
          action             = ["Microsoft.Network/virtualNetworks/subnets/action"]
        }
      }
    }
  }
}

network_security_group_definition = {
  ase = {
    nsg = [
      {
        name                       = "Inbound-management",
        priority                   = "100"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "454-455"
        source_address_prefix      = "AppServiceManagement"
        destination_address_prefix = "*"
      },
      {
        name                       = "Inbound-load-balancer-keep-alive",
        priority                   = "105"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "16001"
        source_address_prefix      = "AzureLoadBalancer"
        destination_address_prefix = "*"
      },
      {
        name                       = "ASE-internal-inbound",
        priority                   = "110"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "10.100.0.0/25"
        destination_address_prefix = "*"
      },
      {
        name                       = "Inbound-HTTP",
        priority                   = "120"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "Inbound-HTTPs",
        priority                   = "130"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "Inbound-FTP",
        priority                   = "140"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "21"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "Inbound-FTPs",
        priority                   = "150"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "990"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "Inbound-FTP-Data",
        priority                   = "160"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "10001-10020"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "Inbound-Remote-Debugging",
        priority                   = "170"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "4016-4022"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "SQL",
        priority                   = "180"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "1433"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "Outbound-443",
        priority                   = "100"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "Outbound-DB",
        priority                   = "110"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "1433"
        source_address_prefix      = "*"
        destination_address_prefix = "sql"
      },
      {
        name                       = "Outbound-DNS",
        priority                   = "120"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "53"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "Outbound-ASE-internal",
        priority                   = "130"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "10.100.0.0/25"
      },
      {
        name                       = "Outbound-80",
        priority                   = "140"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "Outbound-ASE-to-VNET",
        priority                   = "150"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "10.100.0.0/23"
      },
      {
        name                       = "Outbound-NTP",
        priority                   = "160"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "123"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
    ]
  }
}