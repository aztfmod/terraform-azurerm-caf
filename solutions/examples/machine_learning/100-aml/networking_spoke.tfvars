
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