#
# Global settings
#
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
  databricks_re1 = {
    name   = "databricks-re1"
    region = "region1"
  }
}

#
# Databricks workspace settings
#
databricks_workspaces = {
  sales_workspaces = {
    name               = "sales_workspace"
    resource_group_key = "databricks_re1"
    sku                = "premium"

    infrastructure_encryption_enabled = true
    customer_managed_key_enabled      = true

    custom_parameters = {
      no_public_ip = false
    }

    #bug opened on https://github.com/hashicorp/terraform-provider-azurerm/issues/13086
    machine_learning = {
      #id = "optional"
      key = "ml_workspace_re1"
      #lz_key = "optional"
    }
  }
}

#
# Machine learning workspace settings
#
machine_learning_workspaces = {
  ml_workspace_re1 = {
    name                     = "amlwrkspc"
    resource_group_key       = "databricks_re1"
    keyvault_key             = "aml_secrets"
    storage_account_key      = "amlstorage_re1"
    application_insights_key = "ml_app_insight"
    #sku_name                 = "Enterprise" # disabling this will set up Basic
    #Commenting sku_name as deprecated - per https://docs.microsoft.com/en-us/azure/machine-learning/concept-workspace#what-happened-to-enterprise-edition
  }
}

#
# App insights settings
#
azurerm_application_insights = {
  ml_app_insight = {
    name               = "ml-app-insight"
    resource_group_key = "databricks_re1"
    application_type   = "web"
  }
}

#
# Storage account settings
#
storage_accounts = {
  amlstorage_re1 = {
    name                     = "amlwrkspcstg"
    resource_group_key       = "databricks_re1"
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
    name                     = "amlsecrets"
    resource_group_key       = "databricks_re1"
    sku_name                 = "premium"
    soft_delete_enabled      = true
    purge_protection_enabled = true
  }
}
