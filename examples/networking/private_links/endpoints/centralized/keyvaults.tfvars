keyvaults = {

  #
  # Keyvault with service endpoint enabled
  #
  kv_rg1 = {
    name               = "secrets"
    resource_group_key = "rg1"
    sku_name           = "standard"

    # Make sure you set a creation policy.
    creation_policies = {
      logged_in_user = {
        secret_permissions      = ["Set", "Get", "List", "Delete", "Purge"]
        certificate_permissions = ["managecontacts", "manageissuers"]
      }
    }

    network = {
      bypass         = "AzureServices"
      default_action = "Allow"
    }

  }
}