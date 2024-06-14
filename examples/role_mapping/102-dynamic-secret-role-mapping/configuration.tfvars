global_settings = {
  default_region = "region1"
  regions = {
    region1 = "westeurope"
  }
}

resource_groups = {
  rg1 = {
    name = "example-msi-kv-rg1"
  }
}

keyvaults = {
  kv1 = {
    name                      = "kv1examplemsi"
    resource_group_key        = "rg1"
    sku_name                  = "premium"
    soft_delete_enabled       = true
    enable_rbac_authorization = true

    # creation_policies = {}
    # }

  }
}

dynamic_keyvault_secrets = {
  kv1 = {
    domain_join_username = {
      secret_name = "domain-join-username"
      value       = "domainjoinuser@contoso.com"
    }
    domain_join_password = {
      secret_name = "domain-join-password"
      value       = "MyDoma1nVery@Str5ngP!44w0rdToChaNge#"
    }
  }
}

managed_identities = {
  msi1 = { # managed identity key
    name               = "msi1"
    resource_group_key = "rg1"
  }
}

azuread_groups = {
  my_group = { # azuread group key
    name = "my_group"
  }
}

azuread_groups_membership = {
  my_group = { # azuread group key
    managed_identities = {
      members = {
        keys = ["msi1"]
      }
    }
  }
}

role_mapping = {
  built_in_role_mapping = {
    # keyvaults = { 
    #   kv1 = {
    #     "Key Vault Administrator" = {
    #       logged_in = {
    #         keys = ["user"]
    #       }
    #     }
    #   }
    # }
    # To be able to run this example the user/service principal should already have 
    # "Key Vault Administrator" to be able to create dynamic_keyvault_secrets in the newly created keyvault.
    # And set the rights on the secrets
    dynamic_keyvault_secrets = {
      domain_join_username = { # dynamic keyvault secret key to apply role mapping to
        keyvault_key = "kv1" # keyvault key in wich the secret is stored.
        "Key Vault Secrets User" = {
          azuread_groups = {
            keys = ["my_group"]
          }
        }
      }
      domain_join_password = {
        keyvault_key = "kv1"
        "Key Vault Secrets User" = {
          azuread_groups = {
            keys = ["my_group"]
          }
        }
      }
    }
  }
}
