
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
  rg1 = {
    name = "azure-ml"
  }
}

#
# Machine learning workspace settings
#
machine_learning_workspaces = {
  ml_workspace_re1 = {
    name                     = "amlwrkspc"
    resource_group_key       = "rg1"
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
    resource_group_key = "rg1"
    application_type   = "web"
  }
}

#
# Storage account settings
#
storage_accounts = {
  amlstorage_re1 = {
    name                     = "amlwrkspcstg"
    resource_group_key       = "rg1"
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
    resource_group_key  = "rg1"
    sku_name            = "premium"
    soft_delete_enabled = true
  }
}

vnets = {
  vnet1 = {
    resource_group_key = "rg1"
    vnet = {
      name          = "vnet1"
      address_space = ["10.100.100.0/24"]
    }
    specialsubnets = {}
    subnets = {
      subnet1 = {
        name = "subnet1"
        cidr = ["10.100.100.0/29"]
      }
    }

  }
}

machine_learning_compute_instance = {
  mlci1 = {
    name   = "mlci1"
    region = "region1"
    machine_learning_workspace = {
      key = "ml_workspace_re1"
    }
    virtual_machine_size = "STANDARD_DS2_V2"
    authorization_type   = "personal"
    subnet = {
      key      = "subnet1"
      vnet_key = "vnet1"
    }
    description = "foo"
    tags = {
      foo = "bar"
    }
    assign_to_user = {
      #user1
      object_id = "41db5fa5-xxxx-xxxx-xxxx-140f73ac6055"
      #tenant_id = "6700cd11-xxxx-xxxx-xxxx-1a919dd66613"
    }
  }
}