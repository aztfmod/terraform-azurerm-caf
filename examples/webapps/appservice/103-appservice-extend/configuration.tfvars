global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  webapp_extend = {
    name   = "webapp-extend"
    region = "region1"
  }
}

# By default asp1 will inherit from the resource group location
app_service_plans = {
  asp_extend = {
    resource_group_key = "webapp_extend"
    name               = "asp-extend"
    per_site_scaling   = true

    sku = {
      tier = "Standard"
      size = "S1"
    }
  }
}

app_services = {
  webapp1 = {
    resource_group_key   = "webapp_extend"
    name                 = "webapp-extend"
    app_service_plan_key = "asp_extend"

    identity = {
      type                  = "UserAssigned"
      managed_identity_keys = ["webapp_usermsi"]
    }

    settings = {
      enabled                 = true
      number_of_workers       = 2
      client_affinity_enabled = false
      client_cert_enabled     = false
      https_only              = false
      key_vault_reference_identity = {
        key = "webapp_usermsi"
      }

      site_config = {
        default_documents        = ["main.aspx"]
        always_on                = true
        dotnet_framework_version = "v4.0"
        app_command_line         = null         ///sbin/myserver -b 0.0.0.0
        ftps_state               = "AllAllowed" //AllAllowed, FtpsOnly and Disabled
        http2_enabled            = false

      }

      app_settings = {
        "ExampleKeyvaultSecret" = "@Microsoft.KeyVault(VaultName=kv-webapp;SecretName=example-keyvault-secret)"
        "Example"               = "Extend",
        "LZ"                    = "CAF"
      }

      tags = {
        Department = "IT"
      }
    }
  }
}

## MSI configuration
managed_identities = {
  webapp_usermsi = {
    name               = "webapp-usermsi"
    resource_group_key = "webapp_extend"
  }
}

## Keyvault configuration
keyvaults = {
  webapp1 = {
    name                = "webapp"
    resource_group_key  = "webapp_extend"
    sku_name            = "standard"
    soft_delete_enabled = true
    creation_policies = {
      logged_in_user = {
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge"]
      }
      managed_identity = {
        managed_identity_key = "webapp_usermsi"
        secret_permissions   = ["Get"]
      }
    }
  }
}
