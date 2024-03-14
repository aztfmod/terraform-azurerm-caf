global_settings = {
  default_region = "region1"
  regions = {
    region1 = "westus"
  }
}

provider_azurerm_features_template_deployment = {
  delete_nested_items_during_deletion = true
}

resource_groups = {
  rg1 = {
    name   = "rg1"
    region = "region1"
  }
}

managed_identities = {
  appconf1 = {
    name               = "appconf1"
    resource_group_key = "rg1"
  }
}

keyvaults = {
  kv1 = {
    name               = "bbaee456fe3e"
    resource_group_key = "rg1"
    sku_name           = "standard"
    creation_policies = {
      logged_in_user = {
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge"]
      }
    }
  }
}

keyvault_access_policies = {
  kv1 = {
    appconf1 = {
      managed_identity_key = "appconf1"
      secret_permissions   = ["Get"]
    }
  }
}

dynamic_keyvault_secrets = {
  kv1 = {
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

app_config = {
  appconf1 = {
    name               = "56bddacc03bd"
    resource_group_key = "rg1"
    location           = "region1"
    tags = {
      project = "sales"
    }

    identity = {
      type                 = "UserAssigned"
      managed_identity_key = "appconf1"
    }

    # the "App Configuration Data Owner" role must be set before trying to create any key
    # settings = {
    #   admin-password = {
    #     key = "admin-password"
    #     vault_key = {
    #       keyvault = {
    #         key = "kv1"
    #       }
    #       secret_name = "admin-password"
    #     }
    #     label = "credential"
    #   }
    # }
  }
}

role_mapping = {
  built_in_role_mapping = {
    app_config = {
      appconf1 = {
        # this role is needed to be able to create config key inside the App Config
        "App Configuration Data Owner" = {
          logged_in = {
            keys = [
              "app",
              "user"
            ]
          }
        }
      }
    }
  }
}
