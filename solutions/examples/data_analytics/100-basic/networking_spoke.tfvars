
# Requires:
# - caf_launchpad scenario 200+
# - caf_foundations
# - caf_neworking with 200-multi-region-hub

# Commands
# - deploy:
#   rover -lz /tf/caf/solutions/ -var-file /tf/caf/solutions/examples/data_analytics/200-basic-ml/networking_spoke.tfvars -tfstate 200-basic-ml-networking_spoke.tfstate -a apply
# - destroy:
#   rover -lz /tf/caf/solutions/ -var-file /tf/caf/solutions/examples/data_analytics/200-basic-ml/networking_spoke.tfvars -tfstate 200-basic-ml-networking_spoke.tfstate -a destroy

landingzone_name = "dap_networking_spoke"

tfstates = {
  caf_foundations = {
    tfstate = "caf_foundations.tfstate"
  }
  networking = {
    tfstate = "caf_networking.tfstate"
  }
}

resource_groups = {
  dap_spoke_re1 = {
    name   = "dap-vnet-spoke"
    region = "region1"
  }
}

vnets = {
  spoke_dap_re1 = {
    resource_group_key = "dap_spoke_re1"
    region             = "region1"
    vnet = {
      name          = "dap-spoke"
      address_space = ["100.64.52.0/22"]
    }
    specialsubnets = {}
    subnets = {
      AzureBastionSubnet = {
        name    = "AzureBastionSubnet"
        cidr    = ["100.64.52.0/29"]
        nsg_key = "azure_bastion_nsg"
      }
      JumpboxSubnet = {
        name              = "JumpboxSubnet"
        cidr              = ["100.64.52.8/29"]
        service_endpoints = ["Microsoft.Storage"]
      }
      DatalakeStorageSubnet = {
        name              = "DatalakeStorageSubnet"
        cidr              = ["100.64.53.0/25"]
        service_endpoints = ["Microsoft.Storage"]
        # nsg_name          = "datalake_nsg"
      }
      AmlSubnet = {
        name              = "AmlSubnet"
        cidr              = ["100.64.53.128/25"]
        service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault"]
        # nsg_name          = "Ml_Workspace_nsg"
      }
      SynapseSubnet = {
        name              = "SynapseSubnet"
        cidr              = ["100.64.54.0/25"]
        service_endpoints = ["Microsoft.Storage"]
        # nsg_name          = "Synapse_Workspace_nsg"
      }
      private_endpoints = {
        name                                           = "private_endpoints"
        cidr                                           = ["100.64.55.0/24"]
        enforce_private_link_endpoint_network_policies = true
      }
    }

    # you can setup up to 5 keys - vnet diganostic
    diagnostic_profiles = {
      vnet = {
        definition_key   = "networking_all"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }

  }
}

vnet_peerings = {
  spoke_dap_re1_TO_hub_rg1 = {
    name = "spoke_dap_re1_TO_hub_rg1"
    from = {
      vnet_key = "spoke_dap_re1"
    }
    to = {
      tfstate_key = "networking_hub"
      lz_key      = "networking_hub"
      output_key  = "vnets"
      vnet_key    = "hub_rg1"
    }
    allow_virtual_network_access = true
    allow_forwarded_traffic      = false
    allow_gateway_transit        = false
    use_remote_gateways          = false
  }

  hub_rg1_TO_spoke_dap_re1 = {
    name = "hub_rg1_TO_spoke_dap_re1"
    from = {
      tfstate_key = "networking_hub"
      lz_key      = "networking_hub"
      output_key  = "vnets"
      vnet_key    = "hub_rg1"
    }
    to = {
      vnet_key = "spoke_dap_re1"
    }
    allow_virtual_network_access = true
    allow_forwarded_traffic      = true
    allow_gateway_transit        = true
    use_remote_gateways          = false
  }

}

bastion_hosts = {
  bastion_re1 = {
    name               = "bastion"
    resource_group_key = "dap_spoke_re1"
    vnet_key           = "spoke_dap_re1"
    subnet_key         = "AzureBastionSubnet"
    public_ip_key      = "bastion_host_re1"

    # you can setup up to 5 profiles
    diagnostic_profiles = {
      operations = {
        definition_key   = "bastion_host"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }

  }
}

public_ip_addresses = {
  bastion_host_re1 = {
    name                    = "bastion-pip1"
    resource_group_key      = "dap_spoke_re1"
    sku                     = "Standard"
    allocation_method       = "Static"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"

    # you can setup up to 5 key
    diagnostic_profiles = {
      bastion_host_rg1 = {
        definition_key   = "public_ip_address"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }

  }
}


network_security_group_definition = {
  # This entry is applied to all subnets with no NSG defined
  empty_nsg = {

    diagnostic_profiles = {
      nsg = {
        definition_key   = "network_security_group"
        destination_type = "storage"
        destination_key  = "all_regions"
      }
      operations = {
        name             = "operations"
        definition_key   = "network_security_group"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }
  }

  azure_bastion_nsg = {

    diagnostic_profiles = {
      nsg = {
        definition_key   = "network_security_group"
        destination_type = "storage"
        destination_key  = "all_regions"
      }
      operations = {
        name             = "operations"
        definition_key   = "network_security_group"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }

    nsg = [
      {
        name                       = "bastion-in-allow",
        priority                   = "100"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "bastion-control-in-allow-443",
        priority                   = "120"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "135"
        source_address_prefix      = "GatewayManager"
        destination_address_prefix = "*"
      },
      {
        name                       = "Kerberos-password-change",
        priority                   = "121"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "4443"
        source_address_prefix      = "GatewayManager"
        destination_address_prefix = "*"
      },
      {
        name                       = "bastion-vnet-out-allow-22",
        priority                   = "103"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "VirtualNetwork"
      },
      {
        name                       = "bastion-vnet-out-allow-3389",
        priority                   = "101"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "3389"
        source_address_prefix      = "*"
        destination_address_prefix = "VirtualNetwork"
      },
      {
        name                       = "bastion-azure-out-allow",
        priority                   = "120"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "AzureCloud"
      }
    ]
  }
}