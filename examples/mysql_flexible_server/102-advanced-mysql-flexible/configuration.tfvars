global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  mysql_region1 = {
    name   = "mysql-region1"
    region = "region1"
  }
  security_region1 = {
    name = "security-region1"
  }
}

mysql_flexible_server = {
  primary_re1 = {
    name     = "flexible-testservers"
    version  = "8.0.21" #Possible values are 5.7, and 8.0.21
    sku_name = "GP_Standard_D2ds_v4"
    zone     = "1"

    resource_group = {
      key = "mysql_region1"
      # lz_key = ""                           # Set the lz_key if the resource group is remote.
    }

    # Auto-generated administrator credentials stored in azure keyvault when not set (recommended).
    # administrator_username  = "psqladmin"
    # administrator_password  = "ComplxP@ssw0rd!"
    keyvault = {
      key = "mysql_region1" # (Required) when auto-generated.
      # lz_key      = ""                      # Set the lz_key if the keyvault is remote.
    }

    vnet = {
      key        = "vnet_region1"
      subnet_key = "mysql"
      # lz_key      = ""                      # Set the lz_key if the vnet is remote.
    }

    private_dns_zone = {
      key = "dns1"
      # lz_key      = ""                      # Set the lz_key if the private_dns_zone is remote.
    }

    mysql_configurations = {
      mysql_configurations = {
        name  = "interactive_timeout"
        value = "600"
      }
      mysql_configurations1 = {
        name  = "audit_log_include_users"
        value = "testuser"
      }
    }

    mysql_databases = {
      mysql_database = {
        name      = "exampledb"
        charset   = "utf8"
        collation = "utf8_unicode_ci"
      }
      mysql_database1 = {
        name      = "exampledb1"
        charset   = "utf8"
        collation = "utf8_unicode_ci"
      }
    }

    backup_retention_days = 10

    maintenance_window = {
      day_of_week  = "4"
      start_hour   = "1"
      start_minute = "15"
    }

    high_availability = {
      # Must be set only when "zone" is set.
      standby_availability_zone = "2"
    }

    tags = {
      server = "MysqlFlexible"
    }

  }

}

## Keyvault configuration
keyvaults = {
  mysql_region1 = {
    name                = "mysql-test"
    resource_group_key  = "security_region1"
    sku_name            = "standard"
    soft_delete_enabled = true
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
    name               = "sample.private.mysql.database.azure.com"
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