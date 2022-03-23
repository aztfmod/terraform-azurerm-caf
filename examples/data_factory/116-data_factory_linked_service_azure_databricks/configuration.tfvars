global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}
resource_groups = {
  rg1 = {
    name   = "databricks-re1"
    region = "region1"
  }
}
data_factory = {
  df1 = {
    name = "example"
    resource_group = {
      key = "rg1"
      #lz_key = ""
      #name = ""
    }
    identity = {
      type = "SystemAssigned"
    }
  }
}

#
# Databricks workspace settings
#
databricks_workspaces = {
  dtbwsp1 = {
    name               = "dtbwsp1"
    resource_group_key = "rg1"
    sku                = "standard"
  }
}

data_factory_linked_service_azure_databricks = {
  dflsad1 = {
    name = "ADBLinkedServiceViaMSI"
    resource_group = {
      key = "rg1"
      #lz_key  = ""
      #name    = ""
    }
    data_factory = {
      key = "df1"
      #lz_key  = ""
      #name    = ""
    }
    description = "ADB Linked Service via MSI"
    databricks_workspace = {
      key = "dtbwsp1"
      #lz_key    = ""
      #id        = ""
      #adb_domain          = "https://${azurerm_databricks_workspace.example.workspace_url}"
    }

    new_cluster_config = {
      node_type             = "Standard_NC12"
      cluster_version       = "5.5.x-gpu-scala2.11"
      min_number_of_workers = 1
      max_number_of_workers = 5
      driver_node_type      = "Standard_NC12"
      log_destination       = "dbfs:/logs"

      custom_tags = {
        custom_tag1 = "sct_value_1"
        custom_tag2 = "sct_value_2"
      }

      spark_config = {
        config1 = "value1"
        config2 = "value2"
      }

      spark_environment_variables = {
        envVar1 = "value1"
        envVar2 = "value2"
      }

      init_scripts = ["init.sh", "init2.sh"]
    }
  }
}