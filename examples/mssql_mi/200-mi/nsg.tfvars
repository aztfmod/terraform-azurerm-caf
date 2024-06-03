

network_security_group_definition = {
  sqlmi1 = {
    nsg = [
      # Prereq for MI
      {
        name                       = "Microsoft.Sql-managedInstances_UseOnly_mi-sqlmgmt-in-172-25-88-0-24-v9"
        protocol                   = "Tcp"
        source_port_range          = "*"
        source_address_prefix      = "SqlManagement"
        destination_address_prefix = "172.25.88.0/24"
        access                     = "Allow"
        priority                   = "100"
        direction                  = "Inbound"
        destination_port_ranges    = ["9000", "9003", "1438", "1440", "1452"]
      },
      {
        name                       = "Microsoft.Sql-managedInstances_UseOnly_mi-corpsaw-in-172-25-88-0-24-v9"
        protocol                   = "Tcp"
        source_port_range          = "*"
        source_address_prefix      = "CorpNetSaw"
        destination_address_prefix = "172.25.88.0/24"
        access                     = "Allow"
        priority                   = "101"
        direction                  = "Inbound"
        destination_port_ranges    = ["9000", "9003", "1440"]
      },
      {
        name                       = "Microsoft.Sql-managedInstances_UseOnly_mi-corppublic-in-172-25-88-0-24-v9"
        protocol                   = "Tcp"
        source_port_range          = "*"
        source_address_prefix      = "CorpNetPublic"
        destination_address_prefix = "172.25.88.0/24"
        access                     = "Allow"
        priority                   = "102"
        direction                  = "Inbound"
        destination_port_ranges    = ["9000", "9003"]
      },
      {
        name                       = "Microsoft.Sql-managedInstances_UseOnly_mi-healthprobe-in-172-25-88-0-24-v9"
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
        name                       = "Microsoft.Sql-managedInstances_UseOnly_mi-internal-in-172-25-88-0-24-v9"
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
        name                       = "Microsoft.Sql-managedInstances_UseOnly_mi-services-out-172-25-88-0-24-v9"
        protocol                   = "Tcp"
        source_port_range          = "*"
        source_address_prefix      = "172.25.88.0/24"
        destination_address_prefix = "AzureCloud"
        access                     = "Allow"
        priority                   = "100"
        direction                  = "Outbound"
        destination_port_ranges    = ["443", "12000"]
      },
      {
        name                       = "Microsoft.Sql-managedInstances_UseOnly_mi-internal-out-172-25-88-0-24-v9"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "172.25.88.0/24"
        destination_address_prefix = "172.25.88.0/24"
        access                     = "Allow"
        priority                   = "101"
        direction                  = "Outbound"
      }
    ]
  }
  subnet02 = {
    nsg = []
  }
}
