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
    name                          = "sales-re1"
    region                        = "region1"
    resource_group_key            = "mariadb_region1"
    version                       = "10.2"
    sku_name                      = "GP_Gen5_2"
    storage_mb                    = 5120
    administrator_login           = "mariadbadmin"
    keyvault_key                  = "mariadb-re1"
    public_network_access_enabled = true
    auto_grow_enabled = true
    
    tags = {
      segment = "sales"
    }
    
    mariadb_firewall_rules = {
      mariadb-firewall-rules = {
        name = "mariadb-firewallrule"
        resource_group_name = "mariadb_region1"
        server_name         = "sales-rg1"
        start_ip_address    = "52.163.80.201"
        end_ip_address      = "52.163.80.205"
      }
    }

    # mysql_configuration = {
    #   mysql_configuration = {
    #     name = "mysql_server_configuration"
    #     resource_group_name = "mysql_region1"
    #     server_name         = "sales-re1"
    #     value = "600"
    #   }
    # }

    mariadb_database = {
      mariadb_database = {
        name                = "mariadb_server_sampledb"
        resource_group_name = "mariadb_region1"
        server_name         = "sales-re1"
        charset             = "utf8"
        collation           = "utf8_general_ci"
      }
    }
    
    

    # Optional
    # threat_detection_policy = {
    #   enabled = true
    #   disabled_alerts = [
    #     # "Sql_Injection",
    #     # "Sql_Injection_Vulnerability",
    #     # "Access_Anomaly",
    #     # "Data_Exfiltration",
    #     # "Unsafe_Action"
    #   ]
    #   email_account_admins = false
    #   email_addresses           = []
    #   retention_days            = 15
    #   storage_account_key = "security-re1"
    # }

  }

}

storage_accounts = {
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
  }
}

keyvault_access_policies = {
  # A maximum of 16 access policies per keyvault
  mariadb-re1 = {
    logged_in_user = {
      secret_permissions = ["Set", "Get", "List", "Delete", "Purge"]
    }
    logged_in_aad_app = {
      secret_permissions = ["Set", "Get", "List", "Delete", "Purge"]
    }
  }
}


# azuread_groups = {
#   sales_admins = {
#     name        = "sql-sales-admins"
#     description = "Administrators of the sales MySQL server."
#     members = {
#       user_principal_names = []
#       object_ids = [
#       ]
#       group_keys             = []
#       service_principal_keys = []
#     }
#     owners = {
#       user_principal_names = [
#       ]
#       service_principal_keys = []
#       object_ids             = []
#     }
#     prevent_duplicate_name = false
#   }
# }