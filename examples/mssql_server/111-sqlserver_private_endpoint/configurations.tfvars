global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
    region2 = "australiacentral"
  }
}

resource_groups = {
  sql_region1 = {
    name   = "sql-rg1"
    region = "region1"
  }
}

keyvaults = {
  sql-rg1 = {
    name               = "sqlrg1"
    resource_group_key = "sql_region1"
    sku_name           = "standard"

    creation_policies = {
      logged_in_user = {
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge"]
      }
    }
  }
}

vnets = {
  vnet1 = {
    resource_group_key = "sql_region1"
    vnet = {
      name          = "testvnet1"
      address_space = ["10.0.0.0/16"]
    }
    subnets = {
      web = {
        name                                           = "web-subnet"
        cidr                                           = ["10.0.1.0/24"]
        enforce_private_link_endpoint_network_policies = "true"
      }
    }
  }
}

mssql_servers = {
  sales-rg1 = {
    name                = "sales-rg1"
    region              = "region1"
    resource_group_key  = "sql_region1"
    version             = "12.0"
    administrator_login = "sqlsalesadmin"

    # Generate a random password and store it in keyvaul secret
    keyvault_key                  = "sql-rg1"
    connection_policy             = "Default"
    system_msi                    = true
    public_network_access_enabled = false


    tags = {
      segment = "sales"
    }

    # Optional
    private_endpoints = {
      # Require enforce_private_link_endpoint_network_policies set to true on the subnet
      private-link-level4 = {
        name       = "sales-sql-rg1"
        vnet_key   = "vnet1"
        subnet_key = "web"
        #subnet_id          = "/subscriptions/97958dac-f75b-4ee3-9a07-9f436fa73bd4/resourceGroups/ppga-rg-sql-rg1/providers/Microsoft.Network/virtualNetworks/ppga-vnet-testvnet1/subnets/ppga-snet-web-subnet"
        resource_group_key = "sql_region1"

        private_service_connection = {
          name                 = "sales-sql-rg1"
          is_manual_connection = false
          subresource_names    = ["sqlServer"]
        }

        # private_dns = {
        #   zone_group_name = "privatelink_database_windows_net"
        #   # lz_key          = ""   # If the DNS keys are deployed in a remote landingzone
        #   keys = ["privatelink"]
        # }
      }
    }
  }
}

# private_dns = {
#   privatelink = {
#     name               = "privatelink.database.windows.net"
#     resource_group_key = "sql_region1"

#     vnet_links = {
#       devops = {
#         name     = "devops"
#         #lz_key   = "launchpad"
#         vnet_key = "vnet1"
#       }
#     }
#   }
# }



