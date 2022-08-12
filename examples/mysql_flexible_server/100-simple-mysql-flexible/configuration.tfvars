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
  primary_region1 = {
    name     = "vks-flexible-testservers"
    version  = "8.0.21" #Possible values are 5.7, and 8.0.21
    sku_name = "GP_Standard_D2ds_v4"

    resource_group = {
      key = "mysql_region1"
      # lz_key = ""                           # Set the lz_key if the resource group is remote.
    }

    # Auto-generated administrator credentials stored in azure keyvault when not set (recommended).
    #administrator_username  = "psqladmin"
    #administrator_password  = "ComplxP@ssw0rd!"
    keyvault = {
      key = "mysql_region1" # (Required) when auto-generated administrator credentials needed.
      # lz_key      = ""                      # Set the lz_key if the keyvault is remote.
    }

    # [Optional] Firewall Rules for Public Access
    mysql_firewall_rules = {
      mysql-firewall-rule1 = {
        name             = "mysql-firewall-rule1"
        start_ip_address = "10.0.1.10"
        end_ip_address   = "10.0.1.11"
      }
      mysql-firewall-rule2 = {
        name             = "mysql-firewall-rule2"
        start_ip_address = "10.0.2.10"
        end_ip_address   = "10.0.2.11"
      }
    }

    # [Optional] Server Configurations
    mysql_configurations = {
      mysql_configurations = {
        name  = "interactive_timeout"
        value = "600"
      }

    }
    # [Optional] Database Configurations
    mysql_databases = {
      flex_mysql_database = {
        name      = "exampledb"
        collation = "utf8_unicode_ci"
        charset   = "utf8"
      }
    }

    tags = {
      server = "MysqlFlexible"
    }

  }

}

keyvaults = {
  mysql_region1 = {
    name                = "mysql-region123"
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