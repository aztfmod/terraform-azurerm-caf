keyvaults = {
  packer_client = {
    name                = "packerakv"
    resource_group_key  = "sig"
    sku_name            = "standard"
    soft_delete_enabled = true
    tags = {
      tfstate = "level2"
    }
    creation_policies = {
      logged_in_user = {
        # if the key is set to "logged_in_user" add the user running terraform in the keyvault policy
        # More examples in /examples/keyvault
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
    }
  }
}

keyvault_access_policies_azuread_apps = {
  packer_client = {
    packer_client = {
      azuread_app_key    = "packer_client"
      secret_permissions = ["Set", "Get", "List", "Delete"]
    }
  }
}