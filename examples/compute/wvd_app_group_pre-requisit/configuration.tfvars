
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
  wvd_region = {
    name = "wvd-pre"
  }
  
}


keyvaults = {
  wvd_kv = {
    name                = "testkv1"
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

# Store output attributes into keyvault secret
dynamic_keyvault_secrets = {
  wvd_kv = { # Key of the keyvault    
    domain-password = {
      secret_name = "wvd-admin-password"
      value       = ""  #Insert manually 
    }
    vm-password = {
      secret_name = "wvd-vm-password"
      value       = ""  #Insert manually 
    }
    hostpool-token = {
      secret_name = "wvd-hostpool-token"
      value       = ""  #Insert manually 
    }
  }  
  
}

