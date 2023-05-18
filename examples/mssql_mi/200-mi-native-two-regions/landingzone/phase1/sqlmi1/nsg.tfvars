

network_security_group_definition = {
  sqlmi1 = {
    version = 1
    name    = "sqlmi"
    resource_group = {
      key = "networking_region1"
    }
  }
}

# Created and managed by SQLMI
# network_security_security_rules = {
#   Inbound = {
#     100 = {
#       network_security_group_definition = {
#         key = "sqlmi1"
#       }
#       name                  = "Microsoft.Sql-managedInstances_UseOnly_mi-sqlmgmt-in-172-25-88-0-24-v10"
#       access                = "Allow"
#       description           = "Allow MI provisioning Control Plane Deployment and Authentication Service"
#       protocol              = "Tcp"
#       source_port_range     = "*"
#       source_address_prefix = "SqlManagement"
#       destination_address_prefix_from_key = {
#         resource_type = "vnets" # or virtual_subnets
#         vnet_key      = "sqlmi_region1"
#         subnet_key    = "sqlmi1"
#         index         = 0 # Pick the cidr[index]. If not set, default to 0
#       }
#       destination_port_ranges = ["9000", "9003", "1438", "1440", "1452"]
#     }
#     101 = {
#       network_security_group_definition = {
#         key = "sqlmi1"
#       }
#       name                  = "Microsoft.Sql-managedInstances_UseOnly_mi-corpsaw-in-172-25-88-0-24-v10"
#       access                = "Allow"
#       description           = "Allow MI Supportability"
#       protocol              = "Tcp"
#       source_port_range     = "*"
#       source_address_prefix = "CorpNetSaw"
#       destination_address_prefix_from_key = {
#         resource_type = "vnets" # or virtual_subnets
#         vnet_key      = "sqlmi_region1"
#         subnet_key    = "sqlmi1"
#       }
#       destination_port_ranges = ["1440", "9000", "9003"]
#     }
#     102 = {
#       network_security_group_definition = {
#         key = "sqlmi1"
#       }
#       name                  = "Microsoft.Sql-managedInstances_UseOnly_mi-corppublic-in-172-25-88-0-24-v10"
#       access                = "Allow"
#       description           = "Allow MI Supportability through Corpnet ranges"
#       protocol              = "Tcp"
#       source_port_range     = "*"
#       source_address_prefix = "CorpNetPublic"
#       destination_address_prefix_from_key = {
#         resource_type = "vnets" # or virtual_subnets
#         vnet_key      = "sqlmi_region1"
#         subnet_key    = "sqlmi1"
#       }
#       destination_port_ranges = ["9000", "9003"]
#     }
#     103 = {
#       network_security_group_definition = {
#         key = "sqlmi1"
#       }
#       name                   = "Microsoft.Sql-managedInstances_UseOnly_mi-healthprobe-in-172-25-88-0-24-v10"
#       access                 = "Allow"
#       description            = "Allow Azure Load Balancer inbound traffic"
#       protocol               = "*"
#       source_port_range      = "*"
#       destination_port_range = "*"
#       source_address_prefix  = "AzureLoadBalancer"
#       destination_address_prefix_from_key = {
#         resource_type = "vnets" # or virtual_subnets
#         vnet_key      = "sqlmi_region1"
#         subnet_key    = "sqlmi1"
#       }
#     }
#     104 = {
#       network_security_group_definition = {
#         key = "sqlmi1"
#       }
#       name                   = "Microsoft.Sql-managedInstances_UseOnly_mi-internal-in-172-25-88-0-24-v10"
#       access                 = "Allow"
#       description            = "Allow MI internal inbound traffic"
#       protocol               = "*"
#       source_port_range      = "*"
#       destination_port_range = "*"
#       source_address_prefix_from_key = {
#         resource_type = "vnets" # or virtual_subnets
#         vnet_key      = "sqlmi_region1"
#         subnet_key    = "sqlmi1"
#       }
#       destination_address_prefix_from_key = {
#         resource_type = "vnets" # or virtual_subnets
#         vnet_key      = "sqlmi_region1"
#         subnet_key    = "sqlmi1"
#       }
#     }
#   }
#   Outbound = {
#     # 100 = {
#     #   network_security_group_definition = {
#     #     key = "sqlmi1"
#     #   }
#     #   name              = "Microsoft.Sql-managedInstances_UseOnly_mi-services-out-172-25-88-0-24-v10"
#     #   access            = "Allow"
#     #   description       = "Allow MI services outbound traffic over https"
#     #   protocol          = "Tcp"
#     #   source_port_range = "*"
#     #   destination_port_ranges = [
#     #     "12000",
#     #     "443"
#     #   ]
#     #   source_address_prefix_from_key = {
#     #     resource_type = "vnets" # or virtual_subnets
#     #     vnet_key      = "sqlmi_region1"
#     #     subnet_key    = "sqlmi1"
#     #   }
#     #   destination_address_prefix = "AzureCloud"
#     #   access                     = "Allow"
#     # }
#     # 101 = {
#     #   network_security_group_definition = {
#     #     key = "sqlmi1"
#     #   }
#     #   name                   = "Microsoft.Sql-managedInstances_UseOnly_mi-internal-out-172-25-88-0-24-v10"
#     #   access                 = "Allow"
#     #   description            = "Allow MI internal outbound traffic"
#     #   protocol               = "*"
#     #   source_port_range      = "*"
#     #   destination_port_range = "*"
#     #   source_address_prefix_from_key = {
#     #     resource_type = "vnets" # or virtual_subnets
#     #     vnet_key      = "sqlmi_region1"
#     #     subnet_key    = "sqlmi1"
#     #   }
#     #   destination_address_prefix_from_key = {
#     #     resource_type = "vnets" # or virtual_subnets
#     #     vnet_key      = "sqlmi_region1"
#     #     subnet_key    = "sqlmi1"
#     #   }
#     # }
#   }
# }