global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}

resource_groups = {
  webapp_simple = {
    name   = "webapp-simple"
    region = "region1"
  }
}

# By default asp1 will inherit from the resource group location
app_service_plans = {
  asp1 = {
    resource_group_key = "webapp_simple"
    name               = "asp-simple"

    sku = {
      tier = "Standard"
      size = "S1"
    }
  }
}

# https://docs.microsoft.com/en-us/azure/storage/
storage_accounts = {
  sa1 = {
    name               = "sa-simple"
    resource_group_key = "webapp_simple"
    # Account types are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Defaults to StorageV2
    account_kind = "BlobStorage"
    # Account Tier options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid.
    account_tier = "Standard"
    #  Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS
    account_replication_type = "LRS" # https://docs.microsoft.com/en-us/azure/storage/common/storage-redundancy
    containers = {
      backup = {
        name = "webapp-simple"
      }
    }
  }
}

app_services = {
  webapp1 = {
    resource_group_key   = "webapp_simple"
    name                 = "webapp-simple"
    app_service_plan_key = "asp1"

    settings = {
      enabled = true

      backup = {
        name                = "test"
        enabled             = true
        storage_account_key = "sa1"
        container_key       =  "backup"
        //storage_account_url = "https://dcyrstsasimple.blob.core.windows.net/webapp-simple?sv=2019-12-12&ss=b&srt=sco&sp=rwdlacx&se=2021-03-13T12:45:24Z&st=2021-02-01T04:45:24Z&spr=https&sig=HxfsW8lAnVJZsvGmn0ZvtQKHyrxtp3Ay2bumENsCXJo%3D"

        schedule = {
          frequency_interval = 1
          frequency_unit = "Day"
          keep_at_least_one_backup = true
          retention_period_in_days = 1
          //start_time = ""
        }
      }
    }
  }
}