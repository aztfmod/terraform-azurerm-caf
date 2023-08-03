

network_security_group_definition = {
  sqlmi1 = {
    version = 1
    name    = "sqlmi"
    resource_group = {
      key = "networking_region1"
    }
    nsg = [
      # Prereq for MI
      {
        name                       = "Microsoft.Sql-managedInstances_UseOnly_mi-sqlmgmt-in-172-25-88-0-24-v10"
        description                = "Allow MI provisioning Control Plane Deployment and Authentication Service"
        protocol                   = "Tcp"
        source_port_range          = "*"
        source_address_prefix      = "SqlManagement"
        destination_port_range     = ""
        destination_address_prefix = "172.25.88.0/24"
        access                     = "Allow"
        priority                   = "100"
        direction                  = "Inbound"
        destination_port_ranges    = ["9000", "9003", "1438", "1440", "1452"]
      },
      {
        name                       = "Microsoft.Sql-managedInstances_UseOnly_mi-corpsaw-in-172-25-88-0-24-v10"
        description                = "Allow MI Supportability"
        protocol                   = "Tcp"
        source_port_range          = "*"
        source_address_prefix      = "CorpNetSaw"
        destination_address_prefix = "172.25.88.0/24"
        access                     = "Allow"
        priority                   = "101"
        direction                  = "Inbound"
        destination_port_ranges    = ["1440", "9000", "9003"]
      },
      {
        name                       = "Microsoft.Sql-managedInstances_UseOnly_mi-corppublic-in-172-25-88-0-24-v10"
        description                = "Allow MI Supportability through Corpnet ranges"
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
        name                       = "Microsoft.Sql-managedInstances_UseOnly_mi-healthprobe-in-172-25-88-0-24-v10"
        description                = "Allow Azure Load Balancer inbound traffic"
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
        name                       = "Microsoft.Sql-managedInstances_UseOnly_mi-internal-in-172-25-88-0-24-v10"
        description                = "Allow MI internal inbound traffic"
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
        name                       = "Microsoft.Sql-managedInstances_UseOnly_mi-sqlmgmt-in-172-25-88-0-24-v9"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_ranges    = ["1438", "1440", "1452", "9000", "9003"]
        source_address_prefix      = "SqlManagement"
        destination_address_prefix = "172.25.88.0/24"
        access                     = "Allow"
        priority                   = "105"
        direction                  = "Inbound"
      },
      {
        name                       = "Microsoft.Sql-managedInstances_UseOnly_mi-corpsaw-in-172-25-88-0-24-v9"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_ranges    = ["1440", "9000", "9003"]
        source_address_prefix      = "CorpNetSaw"
        destination_address_prefix = "172.25.88.0/24"
        access                     = "Allow"
        priority                   = "106"
        direction                  = "Inbound"
      },
      {
        name                       = "Microsoft.Sql-managedInstances_UseOnly_mi-corppublic-in-172-25-88-0-24-v9"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_ranges    = ["9000", "9003"]
        source_address_prefix      = "CorpNetPublic"
        destination_address_prefix = "172.25.88.0/24"
        access                     = "Allow"
        priority                   = "107"
        direction                  = "Inbound"
      },
      {
        name                       = "Microsoft.Sql-managedInstances_UseOnly_mi-healthprobe-in-172-25-88-0-24-v9"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        destination_port_ranges    = []
        source_address_prefix      = "AzureLoadBalancer"
        destination_address_prefix = "172.25.88.0/24"
        access                     = "Allow"
        priority                   = "108"
        direction                  = "Inbound"
      },
      {
        name                       = "Microsoft.Sql-managedInstances_UseOnly_mi-internal-in-172-25-88-0-24-v9"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        destination_port_ranges    = []
        source_address_prefix      = "172.25.88.0/24"
        destination_address_prefix = "172.25.88.0/24"
        access                     = "Allow"
        priority                   = "109"
        direction                  = "Inbound"
      },
      {
        name                       = "Microsoft.Sql-managedInstances_UseOnly_mi-internal-out-172-25-88-0-24-v10"
        description                = "Allow MI internal outbound traffic"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "172.25.88.0/24"
        destination_address_prefix = "172.25.88.0/24"
        access                     = "Allow"
        priority                   = "100"
        direction                  = "Outbound"
        destination_port_ranges    = []
      },
      {
        name                   = "Microsoft.Sql-managedInstances_UseOnly_mi-services-out-172-25-88-0-24-v10"
        description            = "Allow MI services outbound traffic over https"
        protocol               = "Tcp"
        source_port_range      = "*"
        destination_port_range = ""
        destination_port_ranges = [
          "12000",
          "443"
        ]
        source_address_prefix      = "172.25.88.0/24"
        destination_address_prefix = "AzureCloud"
        access                     = "Allow"
        priority                   = "101"
        direction                  = "Outbound"
      },
      {
        name                       = "Microsoft.Sql-managedInstances_UseOnly_mi-internal-out-172-25-88-0-24-v9"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "172.25.88.0/24"
        destination_address_prefix = "172.25.88.0/24"
        access                     = "Allow"
        priority                   = "102"
        direction                  = "Outbound"
      },
      # NSG For FailOver Replication with sqlmi2
      {
        name                       = "allow-replication-from-mi2-5022",
        priority                   = "1000"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "5022"
        source_address_prefix      = "172.26.96.0/24"
        destination_address_prefix = "172.25.88.0/24"
      },
      {
        name                       = "allow-replication-from-mi2-11000-11999",
        priority                   = "1100"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "11000-11999"
        source_address_prefix      = "172.26.96.0/24"
        destination_address_prefix = "172.25.88.0/24"
      },
      {
        name                       = "allow-replication-to-mi2-5022",
        priority                   = "1000"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "5022"
        source_address_prefix      = "172.25.88.0/24"
        destination_address_prefix = "172.26.96.0/24"
      },
      {
        name                       = "allow-replication-to-mi2-11000-11999",
        priority                   = "1100"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "11000-11999"
        source_address_prefix      = "172.25.88.0/24"
        destination_address_prefix = "172.26.96.0/24"
      }
    ]
  }
  sqlmi2 = {
    version = 1
    name    = "sqlmi"
    resource_group = {
      key = "networking_region2"
    }
    nsg = [
      # Prereq for MI
      {
        name                       = "Microsoft.Sql-managedInstances_UseOnly_mi-sqlmgmt-in-172-26-96-0-24-v10"
        description                = "Allow MI provisioning Control Plane Deployment and Authentication Service"
        protocol                   = "Tcp"
        source_port_range          = "*"
        source_address_prefix      = "SqlManagement"
        destination_port_range     = ""
        destination_address_prefix = "172.26.96.0/24"
        access                     = "Allow"
        priority                   = "100"
        direction                  = "Inbound"
        destination_port_ranges    = ["9000", "9003", "1438", "1440", "1452"]
      },
      {
        name                       = "Microsoft.Sql-managedInstances_UseOnly_mi-corpsaw-in-172-26-96-0-24-v10"
        description                = "Allow MI Supportability"
        protocol                   = "Tcp"
        source_port_range          = "*"
        source_address_prefix      = "CorpNetSaw"
        destination_address_prefix = "172.26.96.0/24"
        access                     = "Allow"
        priority                   = "101"
        direction                  = "Inbound"
        destination_port_ranges    = ["1440", "9000", "9003"]
      },
      {
        name                       = "Microsoft.Sql-managedInstances_UseOnly_mi-corppublic-in-172-26-96-0-24-v10"
        description                = "Allow MI Supportability through Corpnet ranges"
        protocol                   = "Tcp"
        source_port_range          = "*"
        source_address_prefix      = "CorpNetPublic"
        destination_address_prefix = "172.26.96.0/24"
        access                     = "Allow"
        priority                   = "102"
        direction                  = "Inbound"
        destination_port_ranges    = ["9000", "9003"]
      },
      {
        name                       = "Microsoft.Sql-managedInstances_UseOnly_mi-healthprobe-in-172-26-96-0-24-v10"
        description                = "Allow Azure Load Balancer inbound traffic"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "AzureLoadBalancer"
        destination_address_prefix = "172.26.96.0/24"
        access                     = "Allow"
        priority                   = "103"
        direction                  = "Inbound"
      },
      {
        name                       = "Microsoft.Sql-managedInstances_UseOnly_mi-internal-in-172-26-96-0-24-v10"
        description                = "Allow MI internal inbound traffic"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "172.26.96.0/24"
        destination_address_prefix = "172.26.96.0/24"
        access                     = "Allow"
        priority                   = "104"
        direction                  = "Inbound"
      },
      {
        name                       = "Microsoft.Sql-managedInstances_UseOnly_mi-sqlmgmt-in-172-25-96-0-24-v9"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_ranges    = ["1438", "1440", "1452", "9000", "9003"]
        source_address_prefix      = "SqlManagement"
        destination_address_prefix = "172.26.96.0/24"
        access                     = "Allow"
        priority                   = "105"
        direction                  = "Inbound"
      },
      {
        name                       = "Microsoft.Sql-managedInstances_UseOnly_mi-corpsaw-in-172-25-96-0-24-v9"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_ranges    = ["1440", "9000", "9003"]
        source_address_prefix      = "CorpNetSaw"
        destination_address_prefix = "172.26.96.0/24"
        access                     = "Allow"
        priority                   = "106"
        direction                  = "Inbound"
      },
      {
        name                       = "Microsoft.Sql-managedInstances_UseOnly_mi-corppublic-in-172-25-96-0-24-v9"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_ranges    = ["9000", "9003"]
        source_address_prefix      = "CorpNetPublic"
        destination_address_prefix = "172.26.96.0/24"
        access                     = "Allow"
        priority                   = "107"
        direction                  = "Inbound"
      },
      {
        name                       = "Microsoft.Sql-managedInstances_UseOnly_mi-healthprobe-in-172-25-96-0-24-v9"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        destination_port_ranges    = []
        source_address_prefix      = "AzureLoadBalancer"
        destination_address_prefix = "172.26.96.0/24"
        access                     = "Allow"
        priority                   = "108"
        direction                  = "Inbound"
      },
      {
        name                       = "Microsoft.Sql-managedInstances_UseOnly_mi-internal-in-172-25-96-0-24-v9"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        destination_port_ranges    = []
        source_address_prefix      = "172.26.96.0/24"
        destination_address_prefix = "172.26.96.0/24"
        access                     = "Allow"
        priority                   = "109"
        direction                  = "Inbound"
      },
      {
        name                   = "Microsoft.Sql-managedInstances_UseOnly_mi-services-out-172-26-96-0-24-v10"
        description            = "Allow MI services outbound traffic over https"
        protocol               = "Tcp"
        source_port_range      = "*"
        destination_port_range = ""
        destination_port_ranges = [
          "12000",
          "443"
        ]
        source_address_prefix      = "172.26.96.0/24"
        destination_address_prefix = "AzureCloud"
        access                     = "Allow"
        priority                   = "100"
        direction                  = "Outbound"
      },
      {
        name                       = "Microsoft.Sql-managedInstances_UseOnly_mi-internal-out-172-26-96-0-24-v10"
        description                = "Allow MI internal outbound traffic"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        destination_port_ranges    = []
        source_address_prefix      = "172.26.96.0/24"
        destination_address_prefix = "172.26.96.0/24"
        access                     = "Allow"
        priority                   = "101"
        direction                  = "Outbound"
      },
      {
        name                   = "Microsoft.Sql-managedInstances_UseOnly_mi-services-out-172-25-96-0-24-v9"
        protocol               = "Tcp"
        source_port_range      = "*"
        destination_port_range = ""
        destination_port_ranges = [
          "12000",
          "443"
        ]
        source_address_prefix      = "172.26.96.0/24"
        destination_address_prefix = "AzureCloud"
        access                     = "Allow"
        priority                   = "102"
        direction                  = "Outbound"
      },
      {
        name                       = "Microsoft.Sql-managedInstances_UseOnly_mi-internal-out-172-25-96-0-24-v9"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "172.26.96.0/24"
        destination_address_prefix = "172.26.96.0/24"
        access                     = "Allow"
        priority                   = "103"
        direction                  = "Outbound"
      },
      # NSG For FailOver Replication with sqlmi1
      {
        name                       = "allow-replication-from-mi1-5022",
        priority                   = "1000"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "5022"
        source_address_prefix      = "172.25.88.0/24"
        destination_address_prefix = "172.26.96.0/24"
      },
      {
        name                       = "allow-replication-from-mi1-11000-11999",
        priority                   = "1100"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "11000-11999"
        source_address_prefix      = "172.25.88.0/24"
        destination_address_prefix = "172.26.96.0/24"
      },
      {
        name                       = "allow-replication-to-mi1-5022",
        priority                   = "1000"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "5022"
        source_address_prefix      = "172.26.96.0/24"
        destination_address_prefix = "172.25.88.0/24"
      },
      {
        name                       = "allow-replication-to-mi1-11000-11999",
        priority                   = "1100"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "11000-11999"
        source_address_prefix      = "172.26.96.0/24"
        destination_address_prefix = "172.25.88.0/24"
      }
    ]
  }
}
