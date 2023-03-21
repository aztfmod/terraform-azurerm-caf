global_settings = {
  default_region = "region1"
  regions = {
    region1 = "eastus2"
  }
}

provider_azurerm_features_keyvault = {
  // set to true to cleanup the CI
  purge_soft_delete_on_destroy = true
}

resource_groups = {
  kv_region1 = {
    name = "example-rg1"
  }
}

keyvaults = {
  vm-kv = {
    name               = "vm-kv"
    resource_group_key = "kv_region1"
    sku_name           = "standard"
    # cert_password_key  = "cert-password"
    creation_policies = {
      logged_in_user = {
        certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Purge", "Recover", "Getissuers", "Setissuers", "Listissuers", "Deleteissuers", "Manageissuers", "Restore", "Managecontacts"]
        secret_permissions      = ["Set", "Get", "List", "Delete", "Purge"]
      }
    }

  }
}

storage_accounts = {
  sa1 = {
    name               = "sa1dev"
    resource_group_key = "kv_region1"

    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    containers = {
      dev = {
        name = "random"
      }
    }
  }
}

# Store output attributes into keyvault secret
dynamic_keyvault_secrets = {
  vm-kv = { # Key of the keyvault
    admin-username = {
      secret_name = "admin-username"
      value       = "administrator"
    }
    admin-password = {
      secret_name = "admin-password"
      value       = "dynamic"
      config = {
        length           = 25
        special          = true
        override_special = "_!@"
      }
    }
    sasl-jaas-config-value = {
      secret_name = "sasl-jaas-config-value"
      value       = "eichoothah6aich6Jeyan8Eirei8aeghutiexul4nah3eiquie"
      config = {
        # Sometimes applications require a custom secret format value_template provides the ability to customize stored keyvault secret to your needs.
        value_template = "sasl.jaas.config=org.apache.kafka.common.security.plain.PlainLoginModule required username=someuser password=%s;"
      }
    }
    postgres-connection-url-dynamic = {
      secret_name = "postgres-connection-url-dynamic"
      value       = "dynamic"
      config = {
        value_template = "postgres://postgres:%s@127.0.0.1:5432/example"
      }
    }
    storage-account-connection-string-resource = {
      secret_name   = "storage-account-connection-string-resource"
      output_key    = "storage_accounts"
      resource_key  = "sa1"
      attribute_key = "primary_access_key"
      config = {
        value_template = "DefaultEndpointsProtocol=https;AccountName=exampleblobstorage;AccountKey=%s"
      }
    }
  }
}
