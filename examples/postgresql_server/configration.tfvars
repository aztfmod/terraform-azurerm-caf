
resource_groups = {
  sql_region1 = {
    name   = "sql-rg1"
    region = "region1"
  }
  security_region1 = {
    name = "sql-security-rg1"
  }
}


storage_accounts = {
  auditing-rg1 = {
    name                     = "auditingrg1"
    resource_group_key       = "sql_region1"
    region                   = "region1"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "RAGRS"
  }
  security-rg1 = {
    name                     = "securityrg1"
    resource_group_key       = "security_region1"
    region                   = "region1"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "RAGRS"
  }
}

keyvaults = {
  sql-rg1 = {
    name               = "sqlrg1"
    resource_group_key = "security_region1"
    sku_name           = "standard"
  }
}

keyvault_access_policies = {
  # A maximum of 16 access policies per keyvault
  sql-rg1 = {
    logged_in_user = {
      secret_permissions = ["Set", "Get", "List", "Delete", "Purge"]
    }
    logged_in_aad_app = {
      secret_permissions = ["Set", "Get", "List", "Delete", "Purge"]
    }
  }
}

postgresql_servers = {
  sales-rg1 = {
    name                          = "sales-rg1"
    region                        = "region1"
    resource_group_key            = "sql_region1"
    version                       = "11"
    sku_name                      = "GP_Gen5_8"
    administrator_login           = "sqlsalesadmin"
    keyvault_key                  = "sql-rg1"
    connection_policy             = "Default"
    system_msi                    = true
    public_network_access_enabled = false

    extended_auditing_policy = {
      storage_account = {
        key = "auditing-rg1"
      }
      retention_in_days = 7
    }

    azuread_administrator = {
      azuread_group_key = "sales_admins"
    }

    tags = {
      segment = "sales"
    }

    # Optional
    security_alert_policy = {
      enabled = true
      disabled_alerts = [
        # "Sql_Injection",
        # "Sql_Injection_Vulnerability",
        # "Access_Anomaly",
        # "Data_Exfiltration",
        # "Unsafe_Action"
      ]
      email_subscription_admins = false
      email_addresses           = []
      retention_days            = 0

      # Set either the resource_id or the key of the storage account
      storage_account = {
        # resource_id = ""
        key = "security-rg1"
      }

      # Optional
      vulnerability_assessment = {
        enabled = true
        storage_account = {
          # resource_id = ""
          key            = "security-rg1"
          container_path = "vascans"
        }
        email_subscription_admins = false
        email_addresses           = []
      }
    }

  }

}

azuread_groups = {
  sales_admins = {
    name        = "sql-sales-admins"
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