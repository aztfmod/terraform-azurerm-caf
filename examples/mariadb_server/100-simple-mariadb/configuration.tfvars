global_settings = {
  default_region = "region1"
  regions = {
    region1 = "northeurope"
  }
}

resource_groups = {
  mariadb_region1 = {
    name   = "mariadb-re1"
    region = "region1"
    tags = {
      rgtag = "example"
    }
  }
  security_region1 = {
    name = "mariadb-security-re1"
  }
}

mariadb_servers = {
  sales-re1 = {
    name                = "sales-re1"
    region              = "region1"
    resource_group_key  = "mariadb_region1"
    version             = "10.2"
    sku_name            = "GP_Gen5_2"
    storage_mb          = 5120
    administrator_login = "mariadbadmin"
    # Below password argument is used to set the DB password. If not passed, there will be a random password generated and stored in azure keyvault.
    #   administrator_login_password  = "ComplxP@ssw0rd!"
    keyvault_key                  = "mariadb-re1"
    public_network_access_enabled = true
    auto_grow_enabled             = true

    tags = {
      segment = "sales"
    }

    mariadb_firewall_rules = {
      mariadb-firewall-rules = {
        name                = "mariadb-firewallrule"
        resource_group_name = "mariadb_region1"
        server_name         = "sales-rg1"
        start_ip_address    = "10.0.0.1"
        end_ip_address      = "10.0.0.3"
      }
    }

    mariadb_configuration = {
      mariadb_configuration = {
        name                = "interactive_timeout"
        resource_group_name = "mariadb_region1"
        server_name         = "sales-re1"
        value               = "600"
      }
    }


    mariadb_database = {
      mariadb_database = {
        name                = "mariadb_server_sampledb"
        resource_group_name = "mariadb_region1"
        server_name         = "sales-re1"
        charset             = "utf8"
        collation           = "utf8_general_ci"
      }
    }

    extended_auditing_policy = {
      storage_account = {
        key = "auditing-re1"
      }
      retention_in_days = 7
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
    resource_group_key       = "mariadb_region1"
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
  mariadb-re1 = {
    name               = "mariadbre1"
    resource_group_key = "security_region1"
    sku_name           = "standard"
    creation_policies = {
      logged_in_user = {
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge"]
      }
    }
  }
}


