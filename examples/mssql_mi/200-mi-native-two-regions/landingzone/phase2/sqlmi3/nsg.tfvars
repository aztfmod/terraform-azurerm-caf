

network_security_group_definition = {
  sqlmi2 = {
    version = 1
    name    = "sqlmi"
    resource_group = {
      key = "networking_region2"
    }
  }
}

network_security_security_rules = {
  Inbound = {
    # 100 = {
    #   network_security_group_definition = {
    #     key = "sqlmi2"
    #   }
    #   name                  = "Microsoft.Sql-managedInstances_UseOnly_mi-sqlmgmt-in-172-26-96-0-24-v10"
    #   access                = "Allow"
    #   description           = "Allow MI provisioning Control Plane Deployment and Authentication Service"
    #   protocol              = "Tcp"
    #   source_port_range     = "*"
    #   source_address_prefix = "SqlManagement"
    #   destination_address_prefix_from_key = {
    #     resource_type = "vnets" # or virtual_subnets
    #     vnet_key      = "sqlmi_region2"
    #     subnet_key    = "sqlmi2"
    #     index         = 0 # Pick the cidr[index]. If not set, default to 0
    #   }
    #   destination_port_ranges = ["9000", "9003", "1438", "1440", "1452"]
    # }
    # 101 = {
    #   network_security_group_definition = {
    #     key = "sqlmi2"
    #   }
    #   name                  = "Microsoft.Sql-managedInstances_UseOnly_mi-corpsaw-in-172-26-96-0-24-v10"
    #   access                = "Allow"
    #   description           = "Allow MI Supportability"
    #   protocol              = "Tcp"
    #   source_port_range     = "*"
    #   source_address_prefix = "CorpNetSaw"
    #   destination_address_prefix_from_key = {
    #     resource_type = "vnets" # or virtual_subnets
    #     vnet_key      = "sqlmi_region2"
    #     subnet_key    = "sqlmi2"
    #   }
    #   destination_port_ranges = ["1440", "9000", "9003"]
    # }
    # 102 = {
    #   network_security_group_definition = {
    #     key = "sqlmi2"
    #   }
    #   name                  = "Microsoft.Sql-managedInstances_UseOnly_mi-corppublic-in-172-26-96-0-24-v10"
    #   access                = "Allow"
    #   description           = "Allow MI Supportability through Corpnet ranges"
    #   protocol              = "Tcp"
    #   source_port_range     = "*"
    #   source_address_prefix = "CorpNetPublic"
    #   destination_address_prefix_from_key = {
    #     resource_type = "vnets" # or virtual_subnets
    #     vnet_key      = "sqlmi_region2"
    #     subnet_key    = "sqlmi2"
    #   }
    #   destination_port_ranges = ["9000", "9003"]
    # }
    # 103 = {
    #   network_security_group_definition = {
    #     key = "sqlmi2"
    #   }
    #   name                   = "Microsoft.Sql-managedInstances_UseOnly_mi-healthprobe-in-172-26-96-0-24-v10"
    #   access                 = "Allow"
    #   description            = "Allow Azure Load Balancer inbound traffic"
    #   protocol               = "*"
    #   source_port_range      = "*"
    #   destination_port_range = "*"
    #   source_address_prefix  = "AzureLoadBalancer"
    #   destination_address_prefix_from_key = {
    #     resource_type = "vnets" # or virtual_subnets
    #     vnet_key      = "sqlmi_region2"
    #     subnet_key    = "sqlmi2"
    #   }
    # }
    # 104 = {
    #   network_security_group_definition = {
    #     key = "sqlmi2"
    #   }
    #   name                   = "Microsoft.Sql-managedInstances_UseOnly_mi-internal-in-172-26-96-0-24-v10"
    #   access                 = "Allow"
    #   description            = "Allow MI internal inbound traffic"
    #   protocol               = "*"
    #   source_port_range      = "*"
    #   destination_port_range = "*"
    #   source_address_prefix_from_key = {
    #     resource_type = "vnets" # or virtual_subnets
    #     vnet_key      = "sqlmi_region2"
    #     subnet_key    = "sqlmi2"
    #   }
    #   destination_address_prefix_from_key = {
    #     resource_type = "vnets" # or virtual_subnets
    #     vnet_key      = "sqlmi_region2"
    #     subnet_key    = "sqlmi2"
    #   }
    # }
    # NSG For FailOver Replication with sqlmi1
    1000 = {
      network_security_group_definition = {
        key = "sqlmi2"
      }
      name                   = "allow-replication-from-mi1-5022"
      access                 = "Allow"
      protocol               = "*"
      source_port_range      = "*"
      destination_port_range = "5022"
      source_address_prefix_from_key = {
        resource_type = "vnets" # or virtual_subnets
        lz_key        = "sqlmi1"
        vnet_key      = "sqlmi_region1"
        subnet_key    = "sqlmi1"
      }
      destination_address_prefix_from_key = {
        resource_type = "vnets" # or virtual_subnets
        vnet_key      = "sqlmi_region2"
        subnet_key    = "sqlmi2"
      }
    }
    1001 = {
      network_security_group_definition = {
        key = "sqlmi2"
      }
      name                   = "allow-replication-from-mi1-11000-11999"
      access                 = "Allow"
      protocol               = "*"
      source_port_range      = "*"
      destination_port_range = "11000-11999"
      source_address_prefix_from_key = {
        resource_type = "vnets" # or virtual_subnets
        lz_key        = "sqlmi1"
        vnet_key      = "sqlmi_region1"
        subnet_key    = "sqlmi1"
      }
      destination_address_prefix_from_key = {
        resource_type = "vnets" # or virtual_subnets
        vnet_key      = "sqlmi_region2"
        subnet_key    = "sqlmi2"
      }
    }
  }
  Outbound = {
    # 100 = {
    #   network_security_group_definition = {
    #     key = "sqlmi2"
    #   }
    #   name              = "Microsoft.Sql-managedInstances_UseOnly_mi-services-out-172-26-96-0-24-v10"
    #   access            = "Allow"
    #   description       = "Allow MI services outbound traffic over https"
    #   protocol          = "Tcp"
    #   source_port_range = "*"
    #   destination_port_ranges = [
    #     "12000",
    #     "443"
    #   ]
    #   source_address_prefix_from_key = {
    #     resource_type = "vnets" # or virtual_subnets
    #     vnet_key      = "sqlmi_region2"
    #     subnet_key    = "sqlmi2"
    #   }
    #   destination_address_prefix = "AzureCloud"
    #   access                     = "Allow"
    # }
    # 101 = {
    #   network_security_group_definition = {
    #     key = "sqlmi2"
    #   }
    #   name                   = "Microsoft.Sql-managedInstances_UseOnly_mi-internal-out-172-26-96-0-24-v10"
    #   access                 = "Allow"
    #   description            = "Allow MI internal outbound traffic"
    #   protocol               = "*"
    #   source_port_range      = "*"
    #   destination_port_range = "*"
    #   source_address_prefix_from_key = {
    #     resource_type = "vnets" # or virtual_subnets
    #     vnet_key      = "sqlmi_region2"
    #     subnet_key    = "sqlmi2"
    #   }
    #   destination_address_prefix_from_key = {
    #     resource_type = "vnets" # or virtual_subnets
    #     vnet_key      = "sqlmi_region2"
    #     subnet_key    = "sqlmi2"
    #   }
    # }
    1000 = {
      network_security_group_definition = {
        key = "sqlmi2"
      }
      name                   = "allow-replication-to-mi1-5022"
      access                 = "Allow"
      protocol               = "*"
      source_port_range      = "*"
      destination_port_range = "5022"
      source_address_prefix_from_key = {
        resource_type = "vnets" # or virtual_subnets
        vnet_key      = "sqlmi_region2"
        subnet_key    = "sqlmi2"
      }
      destination_address_prefix_from_key = {
        resource_type = "vnets" # or virtual_subnets
        lz_key        = "sqlmi1"
        vnet_key      = "sqlmi_region1"
        subnet_key    = "sqlmi1"
      }
    }
    1001 = {
      network_security_group_definition = {
        key = "sqlmi2"
      }
      name                   = "allow-replication-to-mi1-11000-11999"
      access                 = "Allow"
      protocol               = "*"
      source_port_range      = "*"
      destination_port_range = "11000-11999"
      source_address_prefix_from_key = {
        resource_type = "vnets" # or virtual_subnets
        vnet_key      = "sqlmi_region2"
        subnet_key    = "sqlmi2"
      }
      destination_address_prefix_from_key = {
        resource_type = "vnets" # or virtual_subnets
        lz_key        = "sqlmi1"
        vnet_key      = "sqlmi_region1"
        subnet_key    = "sqlmi1"
      }
    }
  }
}