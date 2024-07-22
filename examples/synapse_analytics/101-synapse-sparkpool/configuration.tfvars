# Requires:
# - caf_launchpad scenario 200+
# - caf_foundations
# - caf_neworking with 200-multi-region-hub
# - 200-basic-ml networking_spoke

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
    # only defining a single firewall rule in this example
    workspace_firewall = {
      name     = "AllowAll"
      start_ip = "0.0.0.0"
      end_ip   = "255.255.255.255"
    }
    synapse_sql_pools = {
      sql_pool_re1 = {
        name                  = "sqlpool1"
        synapse_workspace_key = "synapse_wrkspc_re1"
        sku_name              = "DW100c"
        create_mode           = "Default"
      }
    }
    synapse_spark_pools = {
      spark_pool_re1 = {
        name                  = "sprkpool1" #[name can contain only letters or numbers, must start with a letter, and be between 1 and 15 characters long]
        synapse_workspace_key = "synapse_wrkspc_re1"
        node_size_family      = "MemoryOptimized"
        node_size             = "Small"
        spark_version         = "3.4"
        auto_scale = {
          max_node_count = 50
          min_node_count = 3
        }
        auto_pause = {
          delay_in_minutes = 15
        }
        tags = {
          environment = "Production"
        }
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
          dap = "200-synapse"
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