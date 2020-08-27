# This configuration only work from vscode with a logged in user. More settings are required to get it working in a pipeline.
#
# Requires:
# - caf_launchpad scenario 200+
#
# Commands
# - deploy: rover -lz /tf/caf/examples/ -var-file /tf/caf/examples/mssql_server/mssql-two-regions.tfvars -a apply
# - destroy: 
#   rover -lz /tf/caf/examples/ -var-file /tf/caf/examples/mssql_server/mssql-two-regions.tfvars -a destroy --impersonate
#   rover login to switch back the context to your user
#
# The configuration deploys per region:
# - Two resources groups to store SQL servers and Security services
# - One Keyvault to store the SQL Server admin password in order to support password rotation
# - One Keyvault access policy to grant permission to the logged in user
# - Enable extended auditing, security alerts and vulnerability assessment
# - One Azure AD groups to administer the server
#

default_region = "region1"

regions = {
  region1 = "southeastasia"
  region2 = "eastasia"
}

resource_groups = {
  sql_region1 = {
    name = "sql-rg1"
    region                   = "region1"
  }
  sql_region2 = {
    name = "sql-rg2"
    region                   = "region2"
  }
  security_region1 = {
    name = "sql-security-rg1"
  }
}


storage_accounts = {
  auditing-rg1 = {
    name                     = "auditing"
    resource_group_key       = "sql_region1"
    region                   = "region1"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "RAGRS"
  }
  auditing-rg2 = {
    name                     = "auditing"
    resource_group_key       = "sql_region2"
    region                   = "region2"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "RAGRS"
  }
  security-rg1 = {
    name                     = "security"
    resource_group_key       = "security_region1"
    region                   = "region1"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "RAGRS"
  }
}

keyvaults = {
  sql = {
    name               = "sql"
    resource_group_key = "security_region1"
    sku_name           = "standard"
  }
}

keyvault_access_policies = {
  # A maximum of 16 access policies per keyvault
  sql = {
    bootstrap_user = {
      object_id = "logged_in_user"
      secret_permissions      = ["Set", "Get", "List", "Delete"]
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
    keyvault_key        = "sql"
    connection_policy   = "Default"
    system_msi          = true

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
      enabled            = true
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
        key = "auditing-rg1"
      }

      # Optional
      # vulnerability_assessment = {
      #   enabled = true
      #   storage_account = {
      #     # resource_id = ""
      #     key            = "auditing-rg1"
      #     container_path = "vascans"
      #   }
      #   email_subscription_admins = false
      #   email_addresses           = []
      # }

      # Optional
      private_endpoints = {
        # Require enforce_private_link_endpoint_network_policies set to true on the subnet
        private-link-level4 = {
          name               = "private-endpoint-stg-level4"
          remote_tfstate = {
            tfstate_key        = "foundations"
            lz_key             = "launchpad"
            output_key         = "vnets"
            vnet_key           = "devops_region1"
            subnet_key         = "release_agent_level4"
          }
          resource_group_key = "sql_region1"
          
          private_service_connection = {
            name                 = "private-endpoint-level4"
            is_manual_connection = false
            subresource_names    = ["sqlServer"]
          }
        }
      }
    }

  }

  # You can also decide to put the sql server in the region2 resource group
  sales-rg2 = {
    name                = "sales-rg2"
    region              = "region2"
    resource_group_key  = "sql_region1"
    version             = "12.0"
    administrator_login = "sqlsalesadmin"
    keyvault_key        = "sql"
    connection_policy   = "Default"
    system_msi          = true

    extended_auditing_policy = {
      storage_account = {
        key = "auditing-rg2"
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
      enabled            = true
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
        key = "auditing-rg2"
      }

      # Optional
      vulnerability_assessment = {
        enabled = true
        storage_account = {
          # resource_id = ""
          key            = "auditing-rg2"
          container_path = "vascans"
        }
        email_subscription_admins = false
        email_addresses           = []
      }

      # Optional
      private_endpoints = {
        # Require enforce_private_link_endpoint_network_policies set to true on the subnet
        private-link-level4 = {
          name               = "private-endpoint-stg-level4"
          remote_tfstate = {
            tfstate_key        = "foundations"
            lz_key             = "launchpad"
            output_key         = "vnets"
            vnet_key           = "devops_region1"
            subnet_key         = "release_agent_level4"
          }
          resource_group_key = "sql_region1"
          
          private_service_connection = {
            name                 = "private-endpoint-level4"
            is_manual_connection = false
            subresource_names    = ["sqlServer"]
          }
        }
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
      object_ids           = ["logged_in_user"]
      group_keys           = []

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