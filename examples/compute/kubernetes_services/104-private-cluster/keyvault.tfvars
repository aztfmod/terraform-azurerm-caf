keyvaults = {
  jumpbox = {
    name                = "jumpbox_akv"
    resource_group_key  = "aks_jumpbox_re1"
    sku_name            = "premium"
    soft_delete_enabled = true

    creation_policies = {
      logged_in_user = {
        # if the key is set to "logged_in_user" add the user running terraform in the keyvault policy
        # More examples in /examples/keyvault
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
      logged_in_aad_app = {
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
      # aks_admins = {
      #   azuread_group_key  = "aks_admins"
      #   secret_permissions = ["Get", "List"]
      # }
    }

    # # you can setup up to 5 profiles
    diagnostic_profiles = {
      operations = {
        definition_key   = "default_all"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }

  }
}