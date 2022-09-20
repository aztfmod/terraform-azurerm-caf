global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}

resource_groups = {
  webapp_storage = {
    name   = "webapp-storage"
    region = "region1"
  }
}

# By default asp1 will inherit from the resource group location
app_service_plans = {
  asp_storage = {
    resource_group_key = "webapp_storage"
    name               = "asp-storage"
    kind               = "Linux"
    reserved           = true

    sku = {
      tier = "Standard"
      size = "S1"
    }
  }
}

app_services = {
  webapp_storage = {
    resource_group_key   = "webapp_storage"
    name                 = "webapp_storage"
    app_service_plan_key = "asp_storage"

    settings = {
      enabled = true
      storage_account = [
        {
          name        = "blobmount1"
          type        = "AzureBlob"
          account_key = "sa1"
          share_name  = "sc1"
          mount_path  = "/mnt/sc1"
        },
        {
          name        = "sharemount1"
          type        = "AzureFiles"
          account_key = "sa2"
          share_name  = "fs1"
          mount_path  = "/mnt/fs1"
        }
      ]
    }
  }
}

storage_accounts = {
  sa1 = {
    name                     = "sa1dev"
    resource_group_key       = "webapp_storage"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "LRS"

    containers = {
      sc1 = {
        name = "sc1"
      }
    }
  }
  sa2 = {
    name                     = "sa2dev"
    resource_group_key       = "webapp_storage"
    account_kind             = "FileStorage"
    account_tier             = "Premium"
    account_replication_type = "LRS"
    min_tls_version          = "TLS1_2"
    large_file_share_enabled = true

    file_shares = {
      fs1 = {
        name  = "fs1"
        quota = "100"
      }
    }
  }
}