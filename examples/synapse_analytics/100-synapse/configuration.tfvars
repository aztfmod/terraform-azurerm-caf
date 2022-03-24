
global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

#
# Resource groups to be created
#
resource_groups = {
  dap_synapse_re1 = {
    name = "dap-synapse"
  }
}

#
# Synapse workspace settings
#
synapse_workspaces = {
  synapse_wrkspc_re1 = {
    name                    = "synapsewpc"
    resource_group_key      = "dap_synapse_re1"
    sql_administrator_login = "dbadmin"
    # sql_administrator_login_password = "<string password>"   # If not set use module autogenerate a strong password and stores it in the keyvault
    keyvault_key = "synapse_secrets"
    data_lake_filesystem = {
      storage_account_key = "synapsestorage_re1"
      container_key       = "synaspe_filesystem"
    }
    workspace_firewalls = {
      AllowAll = {
        name     = "AllowAll"
        start_ip = "0.0.0.0"
        end_ip   = "255.255.255.255"
      }
      # example of defining multiple firewall rules; although in this example, makes no sense b/c AllowAll opens to all possible IPs
      AllowSome = {
        # if name attribute is not defined here, key will be used as name ("AllowSome")
        start_ip = "0.0.0.0"
        end_ip   = "10.255.255.255"
      }
    }
  }
}

#
# Storage account settings
#
storage_accounts = {
  synapsestorage_re1 = {
    name                     = "synapsere1"
    resource_group_key       = "dap_synapse_re1"
    account_kind             = "StorageV2"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    access_tier              = "Hot"
    is_hns_enabled           = true

    data_lake_filesystems = {
      synaspe_filesystem = {
        name = "synapsefilesystem"
        properties = {
          dap = "101-synapse"
        }
      }
    }
  }
}

#
# Key Vault settings
#
keyvaults = {
  synapse_secrets = {
    name                = "synapsesecrets"
    resource_group_key  = "dap_synapse_re1"
    sku_name            = "premium"
    soft_delete_enabled = true

    creation_policies = {
      logged_in_user = {
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
    }

    # you can setup up to 5 profiles
    # diagnostic_profiles = {
    #   operations = {
    #     definition_key   = "default_all"
    #     destination_type = "log_analytics"
    #     destination_key  = "central_logs"
    #   }
    # }
  }
}


#
# IAM
#
role_mapping = {
  built_in_role_mapping = {
    storage_accounts = {
      synapsestorage_re1 = {
        "Storage Blob Data Contributor" = {
          synapse_workspaces = {
            keys = ["synapse_wrkspc_re1"]
          }
        }
      }
    }
  }
}