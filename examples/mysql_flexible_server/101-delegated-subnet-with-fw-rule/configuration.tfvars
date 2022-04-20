global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  mysql_region1 = {
    name   = "mysqlflex-test"
    region = "region1"
  }
  security_region1 = {
    name = "security-region12"
  }
}



mysql_flexible_server = {
  primary_region1 = {
    name     = "mysqltest-flexible-server"
    version  = "5.7" #Possible values are 5.7, and 8.0.21
    sku_name = "GP_Standard_D2ds_v4"

    keyvault = {
      key = "mysql-re1" # (Required) when auto-generated administrator credentials needed.
      #   # lz_key      = ""                      # Set the lz_key if the keyvault is remote.
    }

    resource_group = {
      key = "mysql_region1"
      # lz_key = ""                           # Set the lz_key if the resource group is remote.
    }
    # Auto-generated administrator credentials stored in azure keyvault when not set (recommended).
    #administrator_username  = "psqladminss"
    #administrator_password  = "ComplxP@ssw0rd!!"

    vnet = {
      key        = "vnet_region1"
      subnet_key = "mysql"
      # lz_key      = ""                      # Set the lz_key if the vnet is remote.
    }

    private_dns_zone = {
      key = "dns1"
      # lz_key      = ""                      # Set the lz_key if the private_dns_zone is remote.
    }

    mysql_firewall_rules = {
      mysql_rule1 = {
        name             = "mysql-fw-rule1"
        start_ip_address = "10.0.1.10"
        end_ip_address   = "10.0.1.11"
      }
      mysql_rule2 = {
        name             = "mysql-fw-rule2"
        start_ip_address = "10.0.2.10"
        end_ip_address   = "10.0.2.11"
      }
    }

    mysql_configurations = {
      mysql_configurations = {
        name  = "interactive_timeout"
        value = "600"
      }

    }

    mysql_databases = {
      mysql_database = {
        name      = "exampledb"
        charset   = "utf8"
        collation = "utf8_unicode_ci"
      }
    }

    tags = {
      server = "MysqlFlexible"
    }

  }

}

keyvaults = {
  mysql-re1 = {
    name               = "mysqlflextest"
    resource_group_key = "security_region1"
    sku_name           = "standard"
    creation_policies = {
      logged_in_user = {
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge"]
      }
    }
  }
}


## Networking configuration
vnets = {
  vnet_region1 = {
    resource_group_key = "mysql_region1"
    region             = "region1"
    vnet = {
      name          = "mysql"
      address_space = ["10.10.0.0/24"]
    }
    subnets = {
      private_dns = {
        name                                           = "private-dns"
        cidr                                           = ["10.10.0.0/25"]
        enforce_private_link_endpoint_network_policies = true
        enforce_private_link_service_network_policies  = false
      }
      mysql = {
        name                                           = "mysql"
        cidr                                           = ["10.10.0.128/25"]
        enforce_private_link_endpoint_network_policies = true
        delegation = {
          name               = "mysql"
          service_delegation = "Microsoft.DBforMySQL/flexibleServers"
          actions = [
            "Microsoft.Network/virtualNetworks/subnets/join/action",
          ]
        }
      }
    }
  }
}
## Private DNS Configuration
private_dns = {
  dns1 = {
    name               = "sampledb.private.mysql.database.azure.com"
    resource_group_key = "mysql_region1"
    # records = {}
    vnet_links = {
      vnlk1 = {
        name     = "mysql-vnet-link"
        vnet_key = "vnet_region1"
        # lz_key   = ""
      }
    }
  }
}
