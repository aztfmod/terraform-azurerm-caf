global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}

resource_groups = {
  wps_examples = {
    name   = "webpubsub"
    region = "region1"
  }
}

managed_identities = {
  hub_usermsi = {
    name               = "hub_usermsi"
    resource_group_key = "wps_examples"
  }
}

keyvaults = {
  kv_client = {
    name                = "testkv"
    resource_group_key  = "wps_examples"
    sku_name            = "standard"
    soft_delete_enabled = true

    creation_policies = {
      # Required for the ci pipeline principal_id to update KV policies set in keyvault_access_policies
      logged_in_user = {
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
    }
  }
}

keyvault_access_policies = {
  kv_client = {
    hub_usermsi = {
      managed_identity_key = "hub_usermsi"
      secret_permissions   = ["Set", "Get", "List", "Delete", "Purge"]
    }
  }
}

web_pubsubs = {
  wps1 = {
    name = "web_pubsub_1"
    sku  = "Free_F1"
    resource_group = {
      key = "wps_examples"
    }
    region = "region1"
    identity = {
      type                  = "UserAssigned"
      managed_identity_keys = ["hub_usermsi"]
    }
    # To store connection string values in a Keyvault
    keyvaults = {
      kv_client = {
        secret_prefix = "kv-client"
      }
    }
  }
}
