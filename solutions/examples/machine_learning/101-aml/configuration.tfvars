tfstates = {
  caf_foundations = {
    tfstate = "caf_foundations.tfstate"
  }
  networking = {
    tfstate = "networking_spoke_data_analytics.tfstate"
  }
}

resource_groups = {
  dap_azure_ml_re1 = {
    name = "azure-ml"
  }
}

machine_learning_workspaces = {
  ml_workspace = {
    name                     = "amlwrkspc"
    resource_group_key       = "dap_azure_ml_re1"
    keyvault_key             = "aml_secrets"
    storage_account_key      = "amlstorage_re1"
    application_insights_key = "ml_app_insight"
    sku_name                 = "Enterprise" # disabling this will set up Basic
  }
}

azurerm_application_insights = {
  ml_app_insight = {
    name               = "ml-app-insight"
    resource_group_key = "dap_azure_ml_re1"
    application_type   = "web"
  }
}

storage_accounts = {
  amlstorage_re1 = {
    name                     = "amlwrkspcstg"
    resource_group_key       = "dap_azure_ml_re1"
    account_kind             = "StorageV2"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    access_tier              = "Hot"
  }
}

machine_learning_addons = {
  compute_instance = {
    compute_instance_re1 = {
      resource_group_key = "dap_azure_ml_re1"
      computeInstanceName = "instance1"
      machine_learning_workspaces_key = "ml_workspace"
      region = "southeastasia"   #[For allowed value - refer Readme.md]
      vmSize = "Standard_NV6"    #[For allowed value - refer Readme.md]
      sshAccess = "Enabled"   
      adminUserSshPublicKey = "ssh-rsa AAAAB3NzaC1yc2EAABADAQABAAACAQC1"
      vnet_key = "dap-spoke"
      subnet_key = "AmlSubnet"
    }
  }
}

keyvaults = {
  aml_secrets = {
    name               = "amlsecrets"
    resource_group_key = "dap_azure_ml_re1"
    //convention          = "cafrandom"
    sku_name            = "premium"
    soft_delete_enabled = true

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

/* role_mapping = {
  built_in_role_mapping = {
    storage_accounts = {
      amlstorage_re1 = {
        "Storage Blob Data Contributor" = {
          machine_learning_workspaces = [
            "ml_wrkspc44_re1"
          ]
        }
      }
    }
  }
} */