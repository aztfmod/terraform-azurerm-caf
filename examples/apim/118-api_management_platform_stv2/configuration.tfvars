global_settings = {
  default_region = "region1"
  regions = {
    region1 = "uksouth"
  }
  inherit_tags = true
  tags = {
    example = "apim/118-stv2.*"
  }
}

resource_groups = {
  rg_example_apim_uks = {
    name   = "example-apim-uks" # prefix-rg-example-apim-uks
    region = "region1"
    tags = {
      level = "level3"
    }
  }
}

vnets = {
  # Example vNet 
  vnet_example_uks = {
    resource_group_key = "rg_example_apim_uks"
    region             = "region1"
    vnet = {
      name          = "example-uks" # prefix-vnet-example-uks
      address_space = ["10.0.0.0/16"]
    }
    subnets = {

      # Example subnet for APIM private endpoint

      snet_example_apim_uks = {
        name    = "example-apim-uks" #prefix-snet-example-apim-uks
        cidr    = ["10.0.1.0/24"]
        nsg_key = "nsg_example_apim_uks"
        # route_table_key = ""
        service_endpoints = ["Microsoft.KeyVault", "Microsoft.Storage", "Microsoft.Sql", "Microsoft.EventHub", "Microsoft.ServiceBus"] # service endpoints required for APIM
      }
    }
  }
}

network_security_group_definition = {
  # This entry is applied to all subnets with no NSG defined
  empty_nsg_no_log = {}

  # Example NSG for APIM 
  nsg_example_apim_uks = {
    name               = "example-apim-uks" # prefix-nsg-example-apim-uks
    version            = 1
    resource_group_key = "rg_example_apim_uks"
    nsg = [
      {
        name                       = "Inbound-ApiManagement",
        priority                   = "1000"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "3443"
        source_address_prefix      = "ApiManagement"
        destination_address_prefix = "VirtualNetwork"
      },
      {
        name                       = "Inbound-AzureLoadBalancer",
        priority                   = "1010"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "6390"
        source_address_prefix      = "AzureLoadBalancer"
        destination_address_prefix = "VirtualNetwork"
      },
      {
        name                       = "Outbound-Storage",
        priority                   = "1000"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "VirtualNetwork"
        destination_address_prefix = "Storage"
      },
      {
        name                       = "Outbound-SQL",
        priority                   = "1010"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "1443"
        source_address_prefix      = "VirtualNetwork"
        destination_address_prefix = "SQL"
      },
      {
        name                       = "Outbound-AzureKeyVault",
        priority                   = "1020"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "VirtualNetwork"
        destination_address_prefix = "AzureKeyVault"
      },
      {
        name                       = "Outbound-AzureMonitor",
        priority                   = "1030"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_ranges    = ["443", "1886"]
        source_address_prefix      = "VirtualNetwork"
        destination_address_prefix = "AzureMonitor"
      },
    ]
  }
}

public_ip_addresses = {

  # Public IP for the example APIM Instance
  pip_apim_uks = {
    name               = "example-apim-uks" # prefix-pip-example-apim-uks
    region             = "region1"
    resource_group_key = "rg_example_apim_uks"
    sku                = "Standard" # must be 'Standard' SKU

    # Standard SKU Public IP Addresses that do not specify a zone are zone redundant by default.
    allocation_method       = "Static"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"
    domain_name_label       = "example-apim-uks"
  }
}

api_management = {
  apim_uks = {
    name               = "example-uks" # prefix-apim-example-uks
    resource_group_key = "rg_example_apim_uks"
    publisher_name     = "apim.example.sre.com"
    publisher_email    = "example.apim@sre.com"
    sku_name           = "Developer_1" # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management#sku_name
    region             = "region1"

    # Required to deploy APIM on platform verions stv2.*
    public_ip_address = {
      key = "pip_apim_uks"
      # lz_key = ""
    }

    virtual_network_type = "Internal" # The type of virtual network you want to use, valid values include: None, External, Internal. Defaults to None.
    virtual_network_configuration = {
      vnet_key   = "vnet_example_uks"
      subnet_key = "snet_example_apim_uks"
      # lz_key     = ""
    }

    identity = {
      type                  = "UserAssigned"
      managed_identity_keys = ["msi_apim_uks"]
    }

    portal = {
      host_name = "example.apim.com"
    }
  }
}

managed_identities = {
  msi_apim_uks = {
    name               = "example-apim-uks" # prefix-msi-example-apim-uks
    resource_group_key = "rg_example_apim_uks"
  }
}
