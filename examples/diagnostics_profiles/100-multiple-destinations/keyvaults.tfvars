keyvaults = {

  kv1 = {
    name               = "kv"
    resource_group_key = "ops"
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
    diagnostic_profiles = {
      log_analytics = {
        name             = "operational_logs_and_metrics"
        definition_key   = "keyvault"
        destination_type = ["log_analytics", "event_hub", "storage"]
        destination_key  = "central_logs"
      }
    }
  }
}

provider_azurerm_features_keyvault = {
  // set to true to cleanup the CI
  purge_soft_delete_on_destroy = true
}
