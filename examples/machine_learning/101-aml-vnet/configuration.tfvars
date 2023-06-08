global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

provider_azurerm_features_template_deployment = {
  delete_nested_items_during_deletion = true
}

#
# Resource groups to be created
#
resource_groups = {
  dap_azure_ml_re1 = {
    name = "azure-ml"
  }
}

#
# Machine learning workspace settings
#
machine_learning_workspaces = {
  ml_workspace_re1 = {
    name                          = "amlwrkspc"
    resource_group_key            = "dap_azure_ml_re1"
    keyvault_key                  = "aml_secrets"
    storage_account_key           = "amlstorage_re1"
    application_insights_key      = "ml_app_insight"
    public_network_access_enabled = true
    #sku_name                 = "Enterprise" # disabling this will set up Basic
    #Commenting sku_name as deprecated - per https://docs.microsoft.com/en-us/azure/machine-learning/concept-workspace#what-happened-to-enterprise-edition

    # Don't create compute_instances [deprecated] - See examples 102 and 103 for machine_learning_compute_instance
    compute_instances = {
      compute_instance_re1 = {
        computeInstanceName   = "inst25"
        vmSize                = "Standard_DS3_v2" #[For allowed value - refer Readme.md]
        adminUserName         = "azureuser"
        sshAccess             = "Enabled"
        adminUserSshPublicKey = "ssh-rsa AAAAB3NzaC1yc2EAABADAQABAAACAQC1"
        vnet_key              = "spoke_dap_re1"
        subnet_key            = "AmlSubnet"
      }
    }
  }
}

#
# App insights settings
#
azurerm_application_insights = {
  ml_app_insight = {
    name               = "ml-app-insight"
    resource_group_key = "dap_azure_ml_re1"
    application_type   = "web"
  }
}

#
# Storage account settings
#
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

#
# Key Vault settings
#
keyvaults = {
  aml_secrets = {
    name                = "amlsecrets"
    resource_group_key  = "dap_azure_ml_re1"
    sku_name            = "premium"
    soft_delete_enabled = true
  }
}