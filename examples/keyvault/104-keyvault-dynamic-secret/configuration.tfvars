global_settings = {
  default_region = "region1"
  regions = {
    region1 = "eastus2"
  }
}

provider_azurerm_features_keyvault = {
  // set to true to cleanup the CI
  purge_soft_delete_on_destroy = true
}

resource_groups = {
  kv_region1 = {
    name = "example-rg1"
  }
}

keyvaults = {
  vm-kv = {
    name               = "vm-kv"
    resource_group_key = "kv_region1"
    sku_name           = "standard"
    # cert_password_key  = "cert-password"
    creation_policies = {
      logged_in_user = {
        certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Purge", "Recover", "Getissuers", "Setissuers", "Listissuers", "Deleteissuers", "Manageissuers", "Restore", "Managecontacts"]
        secret_permissions      = ["Set", "Get", "List", "Delete", "Purge"]
      }
    }

  }
}

# Store output attributes into keyvault secret
dynamic_keyvault_secrets = {
  vm-kv = { # Key of the keyvault
    admin-username = {
      secret_name = "admin-username"
      value       = "administrator"
    }
    admin-password = {
      secret_name = "admin-password"
      value       = "dynamic"
      config = {
        length           = 25
        special          = true
        override_special = "_!@"
      }
    }
  }
}
