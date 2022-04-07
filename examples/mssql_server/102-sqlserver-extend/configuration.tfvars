# This configuration only work from vscode with a logged in user. More settings are required to get it working in a pipeline.

# Requires:
# - caf_launchpad scenario 200+

# Commands
# - deploy: rover -lz /tf/caf/solutions/ -var-file /tf/caf/solutions/examples/mssql_server/200-mssql.tfvars -tfstate mssql_server.tfstate -a apply
# - destroy:
#   rover -lz /tf/caf/solutions/ -var-file /tf/caf/solutions/examples/mssql_server/200-mssql.tfvars -tfstate mssql_server.tfstate -a destroy

# The configuration deploys one region:
# - Two resources groups to store SQL servers and Security services
# - One Keyvault to store the SQL Server admin password in order to support password rotation
# - One Keyvault access policy to grant permission to the logged in user
# - Enable extended auditing, security alerts and vulnerability assessment
# - One Azure AD groups to administer the server


global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

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

    creation_policies = {
      logged_in_user = {
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge"]
      }
    }
  }
}

mssql_servers = {
  sales-rg1 = {
    name                          = "sales-rg1"
    region                        = "region1"
    resource_group_key            = "sql_region1"
    version                       = "12.0"
    administrator_login           = "sqlsalesadmin"
    keyvault_key                  = "sql-rg1"
    connection_policy             = "Default"
    public_network_access_enabled = false


    identity = {
      type = "SystemAssigned"
    }

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

# The role mapping is a required permission for mssql server identity to use audit_policy
role_mapping = {
  built_in_role_mapping = {
    storage_accounts = {
      auditing-rg1 = {
        "Storage Blob Data Contributor" = {
          mssql_servers = {
            keys = ["sales-rg1"]
          }
        }
      }
    }
  }
}