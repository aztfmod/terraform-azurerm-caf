
global_settings = {
  default_region = "region1"
  environment    = "test"
  regions = {
    region1 = "East US"
    region2 = "southeastasia"

  }
}


resource_groups = {
  # Default to var.global_settings.default_region. You can overwrite it by setting the attribute region = "region2"
  wvd_region1 = {
    name = "wvd-pre"
  }

}

keyvaults = {
  wvd_kv1 = {
    name                = "wvdkv1"
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

  wvd_kv2 = {
    name                = "wvdkv2"
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

  wvd_kv3 = {
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

}


dynamic_keyvault_secrets = {
  wvd_kv1 = { # Key of the keyvault    
    domain-password = {
      secret_name = "newwvd-admin-password"
      value       = "" #Insert manually 
    }
  }

  wvd_kv2 = { # Key of the keyvault    
    vm-password = {
      secret_name = "newwvd-vm-password"
      value       = "" #Insert manually 
    }

  }

  wvd_kv3 = { # Key of the keyvault    
    hostpool-token = {
      secret_name = "newwvd-hostpool-token"
      value       = "" #Insert manually 
    }
  }

}


