vnets = {
  spoke_dap_re1 = {
    resource_group_key = "dap_azure_ml_re1"
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
        nsg_key           = "empty_nsg"
      }
      DatalakeStorageSubnet = {
        name              = "DatalakeStorageSubnet"
        cidr              = ["100.64.53.0/25"]
        service_endpoints = ["Microsoft.Storage"]
        nsg_key           = "empty_nsg"
      }
      AmlSubnet = {
        name              = "AmlSubnet"
        cidr              = ["100.64.53.128/25"]
        service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault"]
        nsg_key           = "machine_learning_nsg"
      }
      SynapseSubnet = {
        name              = "SynapseSubnet"
        cidr              = ["100.64.54.0/25"]
        service_endpoints = ["Microsoft.Storage"]
        nsg_key           = "empty_nsg"
      }
      private_endpoints = {
        name                                           = "private_endpoints"
        cidr                                           = ["100.64.55.0/24"]
        enforce_private_link_endpoint_network_policies = true
      }
    }
  }
}

network_security_group_definition = {
  # This entry is applied to all subnets with no NSG defined
  empty_nsg = {
    nsg = []
  }

  azure_bastion_nsg = {
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
  machine_learning_nsg = {
    nsg = [
      {
        name                       = "aml_allow_44224",
        priority                   = "100"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "44224"
        source_address_prefix      = "AzureMachineLearning"
        destination_address_prefix = "*"
      },
      {
        name                       = "aml_allow_29876_29877",
        priority                   = "110"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "29876-29877"
        source_address_prefix      = "BatchNodeManagement"
        destination_address_prefix = "*"
      }
    ]
  }
}