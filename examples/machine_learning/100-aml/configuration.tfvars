resource_groups = {
  dap_azure_ml_re1 = {
    name = "azure-ml"
  }
}

machine_learning_workspaces = {
  ml_workspace_re1 = {
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

keyvaults = {
  aml_secrets = {
    name                = "amlsecrets"
    resource_group_key  = "dap_azure_ml_re1"
    sku_name            = "premium"
    soft_delete_enabled = true
  }
}
