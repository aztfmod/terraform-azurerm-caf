

network_security_group_definition = {
  sqlmi = {
    nsg = [
      {
        name                       = "Microsoft.Sql-managedInstances_UseOnly_mi-sqlmgmt-in-10-0-0-0-24-v9"
        protocol                   = "Tcp"
        source_port_range          = "*"
        source_address_prefix      = "SqlManagement"
        destination_address_prefix = "172.25.88.0/24"
        access                     = "Allow"
        priority                   = "100"
        direction                  = "Inbound"
        destination_port_ranges    = ["9000","9003","1438","1440","1452"]
      },
      {
        name                       = "Microsoft.Sql-managedInstances_UseOnly_mi-corpsaw-in-10-0-0-0-24-v9"
        protocol                   = "Tcp"
        source_port_range          = "*"
        source_address_prefix      = "CorpNetSaw"
        destination_address_prefix = "172.25.88.0/24"
        access                     = "Allow"
        priority                   = "101"
        direction                  = "Inbound"
        destination_port_ranges    = ["9000","9003","1440"]
      },
      {
        name                       = "Microsoft.Sql-managedInstances_UseOnly_mi-corppublic-in-10-0-0-0-24-v9"
        protocol                   = "Tcp"
        source_port_range          = "*"
        source_address_prefix      = "CorpNetPublic"
        destination_address_prefix = "172.25.88.0/24"
        access                     = "Allow"
        priority                   = "102"
        direction                  = "Inbound"
        destination_port_ranges    = ["9000","9003"]
      },
      {
        name                       = "Microsoft.Sql-managedInstances_UseOnly_mi-healthprobe-in-10-0-0-0-24-v9"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "AzureLoadBalancer"
        destination_address_prefix = "172.25.88.0/24"
        access                     = "Allow"
        priority                   = "103"
        direction                  = "Inbound"
      },
      {
        name                       = "Microsoft.Sql-managedInstances_UseOnly_mi-internal-in-10-0-0-0-24-v9"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "172.25.88.0/24"
        destination_address_prefix = "172.25.88.0/24"
        access                     = "Allow"
        priority                   = "104"
        direction                  = "Inbound"
      },
      {
        name                       = "Microsoft.Sql-managedInstances_UseOnly_mi-services-out-10-0-0-0-24-v9"
        protocol                   = "Tcp"
        source_port_range          = "*"
        source_address_prefix      = "172.25.88.0/24"
        destination_address_prefix = "AzureCloud"
        access                     = "Allow"
        priority                   = "100"
        direction                  = "Outbound"
        destination_port_ranges    = ["443","12000"]
      },
      {
        name                       = "Microsoft.Sql-managedInstances_UseOnly_mi-internal-out-10-0-0-0-24-v9"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "172.25.88.0/24"
        destination_address_prefix = "172.25.88.0/24"
        access                     = "Allow"
        priority                   = "101"
        direction                  = "Outbound"
      },
      # {
      #   name                       = "allow_tds_inbound"
      #   protocol                   = "Tcp"
      #   source_port_range          = "*"
      #   destination_port_range     = "1433"
      #   source_address_prefix      = "VirtualNetwork"
      #   destination_address_prefix = "172.25.88.0/24"
      #   access                     = "Allow"
      #   priority                   = "1000"
      #   direction                  = "Inbound"
      # },
      # {
      #   name                       = "allow_redirect_inbound"
      #   protocol                   = "Tcp"
      #   source_port_range          = "*"
      #   destination_port_range     = "11000-11999"
      #   source_address_prefix      = "VirtualNetwork"
      #   destination_address_prefix = "172.25.88.0/24"
      #   access                     = "Allow"
      #   priority                   = "1100"
      #   direction                  = "Inbound"
      # },
      # {
      #   name                       = "allow_geodr_inbound"
      #   protocol                   = "Tcp"
      #   source_port_range          = "*"
      #   destination_port_range     = "5022"
      #   source_address_prefix      = "VirtualNetwork"
      #   destination_address_prefix = "172.25.88.0/24"
      #   access                     = "Allow"
      #   priority                   = "1200"
      #   direction                  = "Inbound"
      # },
      # {
      #   name                       = "deny_all_inbound"
      #   protocol                   = "*"
      #   source_port_range          = "*"
      #   destination_port_range     = "*"
      #   source_address_prefix      = "*"
      #   destination_address_prefix = "*"
      #   access                     = "Deny"
      #   priority                   = "4096"
      #   direction                  = "Inbound"
      # },
      # {
      #   name                       = "allow_linkedserver_outbound"
      #   protocol                   = "Tcp"
      #   source_port_range          = "*"
      #   destination_port_range     = "1433"
      #   source_address_prefix      = "172.25.88.0/24"
      #   destination_address_prefix = "VirtualNetwork"
      #   access                     = "Allow"
      #   priority                   = "1000"
      #   direction                  = "Outbound"
      # },
      # {
      #   name                       = "allow_redirect_outbound"
      #   protocol                   = "Tcp"
      #   source_port_range          = "*"
      #   destination_port_range     = "11000-11999"
      #   source_address_prefix      = "172.25.88.0/24"
      #   destination_address_prefix = "VirtualNetwork"
      #   access                     = "Allow"
      #   priority                   = "1100"
      #   direction                  = "Outbound"
      # },
      # {
      #   name                       = "allow_geodr_outbound"
      #   protocol                   = "Tcp"
      #   source_port_range          = "*"
      #   destination_port_range     = "5022"
      #   source_address_prefix      = "172.25.88.0/24"
      #   destination_address_prefix = "VirtualNetwork"
      #   access                     = "Allow"
      #   priority                   = "1200"
      #   direction                  = "Outbound"
      # },
      # {
      #   name                       = "allow_privatelink_outbound"
      #   protocol                   = "Tcp"
      #   source_port_range          = "*"
      #   destination_port_range     = "443"
      #   source_address_prefix      = "172.25.88.0/24"
      #   destination_address_prefix = "VirtualNetwork"
      #   access                     = "Allow"
      #   priority                   = "1300"
      #   direction                  = "Outbound"
      # },
      # {
      #   name                       = "deny_all_outbound"
      #   protocol                   = "*"
      #   source_port_range          = "*"
      #   destination_port_range     = "*"
      #   source_address_prefix      = "*"
      #   destination_address_prefix = "*"
      #   access                     = "Deny"
      #   priority                   = "4096"
      #   direction                  = "Outbound"
      # }
    ]
  }
}