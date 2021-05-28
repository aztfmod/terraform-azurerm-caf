
keyvaults = {
  host_pool_secrets = {
    region              = "region2"
    name                = "wvdkv3"
    resource_group_key  = "wvd_region1"
    sku_name            = "standard"
    soft_delete_enabled = true
    creation_policies = {
      logged_in_user = {
        # if the key is set to "logged_in_user" add the user running terraform in the keyvault policy
        # More examples in /examples/keyvault
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
    }
  }

  example_vm_rg1 = {
    name               = "vmsecretskv"
    resource_group_key = "vm_region1"
    sku_name           = "standard"
    tags = {
      env = "Standalone"
    }
    creation_policies = {
      logged_in_user = {
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
    }
  }
}

