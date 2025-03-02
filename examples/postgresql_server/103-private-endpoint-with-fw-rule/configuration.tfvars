global_settings = {
  default_region = "region1"
  regions = {
    region1 = "northeurope"
  }
}

resource_groups = {
  postgresql_region1 = {
    name   = "postgresql-re1"
    region = "region1"
  }
  security_region1 = {
    name = "postgre-sql-security-re1"
  }
}

postgresql_servers = {
  sales-re1 = {
    name                = "sales-re1"
    region              = "region1"
    resource_group_key  = "postgresql_region1"
    version             = "9.6"
    sku_name            = "GP_Gen5_2"
    administrator_login = "postgresqlsalesadmin"
    #   Below password argument is used to set the DB password. If not passed, there will be a random password generated and stored in azure keyvault.
    #   administrator_login_password  = "ComplxP@ssw0rd!"
    keyvault_key                  = "postgresql-re1"
    connection_policy             = "Default"
    system_msi                    = true
    public_network_access_enabled = true
    auto_grow_enabled             = true
    vnet_key                      = "vnet_region1"
    subnet_key                    = "postgresql_subnet"

    extended_auditing_policy = {
      storage_account = {
        key = "auditing-re1"
      }
      retention_in_days = 7
    }


    postgresql_firewall_rules = {
      postgresql-firewall-rule1 = {
        name                = "postgresql_server_firewallrule1"
        resource_group_name = "postgresql_region1"
        server_name         = "sales-re1"
        start_ip_address    = "10.0.1.10"
        end_ip_address      = "10.0.1.11"
      }
      postgresql-firewall-rule2 = {
        name                = "postgresql_server_firewallrule2"
        resource_group_name = "postgresql_region1"
        server_name         = "sales-re1"
        start_ip_address    = "10.0.2.10"
        end_ip_address      = "10.0.2.11"
      }
    }


    postgresql_configurations = {
      postgresql_configuration1 = {
        name                = "backslash_quote"
        resource_group_name = "postgresql_region1"
        server_name         = "sales-re1"
        value               = "on"
      }
    }

    postgresql_databases = {
      postgresql_database = {
        name                = "postgresql_server_sampledb"
        resource_group_name = "postgresql_region1"
        server_name         = "sales-re1"
        charset             = "UTF8"
        collation           = "English_United States.1252"
      }
    }

    azuread_administrator = {
      azuread_group_key = "sales_admins"
    }

    tags = {
      segment = "sales"
    }

    # Optional
    private_endpoints = {
      # Require enforce_private_link_endpoint_network_policies set to true on the subnet
      private-link-level4 = {
        name               = "sales-postgresql-re1"
        vnet_key           = "vnet_region1"
        subnet_key         = "postgresql_subnet"
        resource_group_key = "postgresql_region1"

        private_service_connection = {
          name                 = "sales-postgresql-re1"
          is_manual_connection = false
          subresource_names    = ["postgresqlServer"]
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
    }

  }

}

storage_accounts = {
  auditing-re1 = {
    name                     = "auditingre1"
    resource_group_key       = "postgresql_region1"
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
  postgresql-re1 = {
    name               = "postgresqlre1"
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
    resource_group_key = "postgresql_region1"

    vnet = {
      name          = "postgresql-vnet"
      address_space = ["10.150.102.0/24"]

    }
    #specialsubnets = {}
    subnets = {
      postgresql_subnet = {
        name                                           = "postgresql_subnet"
        cidr                                           = ["10.150.102.0/25"]
        private_endpoint_network_policies = "Enabled"
      }
    }

  }
}


azuread_groups = {
  sales_admins = {
    name        = "postgresql-sales-admins"
    description = "Administrators of the sales SQL server."
    members = {
      user_principal_names = []
      object_ids = [
      ]
      group_keys             = []
      service_principal_keys = []
    }
    owners = {
      user_principal_names = [
      ]
      service_principal_keys = []
      object_ids             = []
    }
    prevent_duplicate_name = false
  }
}

