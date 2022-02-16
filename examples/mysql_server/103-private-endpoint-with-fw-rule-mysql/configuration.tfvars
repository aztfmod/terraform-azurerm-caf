global_settings = {
  default_region = "region1"
  regions = {
    region1 = "northeurope"
  }
}

resource_groups = {
  mysql_region1 = {
    name   = "mysql-re1"
    region = "region1"
    tags = {
      rgtag = "example"
    }
  }
  security_region1 = {
    name = "mysql-security-re1"
  }
}

mysql_servers = {
  sales-re1 = {
    name                = "sales-re1"
    region              = "region1"
    resource_group_key  = "mysql_region1"
    version             = "5.7"
    sku_name            = "GP_Gen5_2"
    storage_mb          = 5120
    administrator_login = "mysqlsalesadmin"
    #   Below password argument is used to set the DB password. If not passed, there will be a random password generated and stored in azure keyvault.
    #   administrator_login_password  = "ComplxP@ssw0rd!"
    keyvault_key                  = "mysql-re1"
    system_msi                    = true
    public_network_access_enabled = true
    auto_grow_enabled             = true
    vnet_key                      = "vnet_region1"
    subnet_key                    = "mysql_subnet"


    extended_auditing_policy = {
      storage_account = {
        key = "auditing-re1"
      }
      retention_in_days = 7
    }

    mysql_firewall_rules = {
      mysql-firewall-rule = {
        name             = "mysql_server_firewallrule"
        start_ip_address = "52.163.80.201"
        end_ip_address   = "52.163.80.201"
      }
    }

    mysql_configurations = {
      mysql_configuration = {
        name  = "interactive_timeout"
        value = "600"
      }
    }

    mysql_databases = {
      mysql_database = {
        name      = "mysql_server_sampledb"
        charset   = "UTF8"
        collation = "utf8_unicode_ci"
      }
    }

    tags = {
      segment = "sales"
    }

    # Optional
    private_endpoints = {
      # Require enforce_private_link_endpoint_network_policies set to true on the subnet
      private-link-level4 = {
        name               = "sales-mysql-re1"
        vnet_key           = "vnet_region1"
        subnet_key         = "mysql_subnet"
        resource_group_key = "mysql_region1"

        private_service_connection = {
          name                 = "sales-mysql-re1"
          is_manual_connection = false
          subresource_names    = ["mysqlServer"]
        }
      }
    }

    # Optional
    threat_detection_policy = {
      enabled = true
      disabled_alerts = [
        # "Sql_Injection",
        # "Sql_Injection_Vulnerability",
        # "Access_Anomaly",
        # "Data_Exfiltration",
        # "Unsafe_Action"
      ]
      email_account_admins = false
      email_addresses      = []
      retention_days       = 15
      storage_account_key  = "security-re1"
    }

  }

}

storage_accounts = {
  auditing-re1 = {
    name                     = "auditingre1"
    resource_group_key       = "mysql_region1"
    region                   = "region1"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "RAGRS"
  }
  security-re1 = {
    name                     = "securityre1"
    resource_group_key       = "security_region1"
    region                   = "region1"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "RAGRS"
  }
}

keyvaults = {
  mysql-re1 = {
    name               = "mysqlre1"
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

    vnet = {
      name          = "mysql-vnet"
      address_space = ["10.150.100.0/24"]

    }
    #specialsubnets = {}
    subnets = {
      mysql_subnet = {
        name                                           = "mysql_subnet"
        cidr                                           = ["10.150.100.0/25"]
        enforce_private_link_endpoint_network_policies = "true"

      }
    }

  }
}

