global_settings = {
  default_region = "region1"
  environment    = "test"
  regions = {
    region1 = "East US"
    region2 = "australiaeast"
  }
}

resource_groups = {
  # Default to var.global_settings.default_region. You can overwrite it by setting the attribute region = "region2"
  wvd_region1 = {
    name = "wvd-pre"
  }
}

wvd_application_groups = {
  wvd_app_group_1 = {
    resource_group_key = "wvd_region1"
    host_pool_key      = "wvd_hp1"
    wvd_workspace_key  = "wvd_ws1"
    name               = "desktopgroup"
    friendly_name      = "Published Desktop"
    description        = "A description of my workspace"
    #Type of Virtual Desktop Application Group. Valid options are RemoteApp or Desktop.
    type = "Desktop"
  }
  wvd_app_group_2 = {
    resource_group_key = "wvd_region1"
    host_pool_key      = "wvd_hp1"
    wvd_workspace_key  = "wvd_ws1"
    name               = "appgroup"
    friendly_name      = "Published Application"
    description        = "Acceptance Test: An application group"
    #Type of Virtual Desktop Application Group. Valid options are RemoteApp or Desktop.
    type = "RemoteApp"
  }
}

wvd_applications = {
  wvd_app1 = {
    name                         = "googlechrome"
    application_group_key        = "wvd_app_group_2"
    friendly_name                = "Google Chrome"
    description                  = "Chromium based web browser"
    path                         = "C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe"
    command_line_argument_policy = "DoNotAllow"
    command_line_arguments       = "--incognito"
    show_in_portal               = false
    icon_path                    = "C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe"
    icon_index                   = 0
  }
}

wvd_host_pools = {
  wvd_hp1 = {
    resource_group_key   = "wvd_region1"
    name                 = "armhp"
    friendly_name        = "Myhostpool"
    description          = "A description of my workspace"
    validate_environment = false
    type                 = "Pooled"
    #Option to specify the preferred Application Group type for the Virtual Desktop Host Pool. Valid options are None, Desktop or RailApplications.
    preferred_app_group_type = "Desktop"
    maximum_sessions_allowed = 1000
    load_balancer_type       = "DepthFirst"
    #Expiration value should be between 1 hour and 30 days.
    registration_info = {
      token_validity = "720h" #in hours (30d)
    }
  }
}

wvd_workspaces = {
  wvd_ws1 = {
    resource_group_key = "wvd_region1"
    name               = "myws"
    friendly_name      = "Myworkspace"
    description        = "A description of my workspace"
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

  wvd_kv3 = {
    hostpool-token = {
      # this secret is retrieved automatically from the module run output
      secret_name   = "newwvd-hostpool-token"
      output_key    = "wvd_host_pools"
      resource_key  = "wvd_hp1"
      attribute_key = "token"
    }
  }
}