
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


azuread_apps = {
  wvd_tenant = {
    useprefix                    = true
    application_name             = "wvd-tenant"
    password_expire_in_days      = 1
    app_role_assignment_required = true
    keyvaults = {
      wvd_kv = {
        secret_prefix = "wvd-tenant"
      }
    }
    # Store the ${secret_prefix}-client-id, ${secret_prefix}-client-secret...
    # Set the policy during the creation process of the launchpad
  }
}

keyvaults = {
  wvd_kv = {
    name                = "testkv"
    resource_group_key  = "wvd_region"
    sku_name            = "standard"
    soft_delete_enabled = true
    lz_key = "wvd_pre"
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
      secret_name = "wvd-domain-password"
      value       = ""  #Insert manually for AD Domain Join extension to use
    }
  }
}
