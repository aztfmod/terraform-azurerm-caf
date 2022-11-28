global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  test = {
    name = "test"
  }
}

# https://docs.microsoft.com/en-us/azure/storage/
storage_accounts = {
  sa1 = {
    name                     = "sa1dev"
    resource_group_key       = "test"
    account_kind             = "StorageV2" #Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Defaults to StorageV2
    account_tier             = "Standard"  #Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid
    account_replication_type = "LRS"       # https://docs.microsoft.com/en-us/azure/storage/common/storage-redundancy
    min_tls_version          = "TLS1_2"    # Possible values are TLS1_0, TLS1_1, and TLS1_2. Defaults to TLS1_0 for new storage accounts.
    allow_blob_public_access = false
    is_hns_enabled           = false

    # Enable this block, if you have a valid domain name
    # custom_domain = {
    #   name          = "any-valid-domain.name" #will be validated by Azure
    #   use_subdomain = true
    # }

    enable_system_msi = {
      type = "SystemAssigned"
    }

    blob_properties = {
      cors_rule = {
        # https://docs.microsoft.com/en-us/rest/api/storageservices/cross-origin-resource-sharing--cors--support-for-the-azure-storage-services
        allowed_headers    = ["x-ms-meta-data*", "x-ms-meta-target*", "x-ms-meta-abc"]
        allowed_methods    = ["POST", "GET"]
        allowed_origins    = ["http://www.contoso.com", "http://www.fabrikam.com"]
        exposed_headers    = ["x-ms-meta-*"]
        max_age_in_seconds = "200"
      }
    }

    delete_retention_policy = {
      days = "7"
    }

    # queue_properties = {
    #   cors_rule = {
    #     # https://docs.microsoft.com/en-us/rest/api/storageservices/cross-origin-resource-sharing--cors--support-for-the-azure-storage-services
    #     allowed_headers    = ["x-ms-meta-data*", "x-ms-meta-target*", "x-ms-meta-abc"]
    #     allowed_methods    = ["POST", "GET"]
    #     allowed_origins    = ["http://www.contoso.com", "http://www.fabrikam.com"]
    #     exposed_headers    = ["x-ms-meta-*"]
    #     max_age_in_seconds = "200"
    #   }
    # }

    logging = {
      delete                = true
      read                  = true
      write                 = true
      version               = true
      retention_policy_days = "7"
    }

    minute_metrics = {
      enabled               = true
      version               = true
      include_apis          = true
      retention_policy_days = "7"
    }

    hour_metrics = {
      enabled               = true
      version               = true
      include_apis          = true
      retention_policy_days = "7"
    }

    static_website = { # supported only with BlockBlobStorage and StorageV2
      index_document     = "index.html"
      error_404_document = "error.html"
    }

    tags = {
      environment = "dev"
      team        = "IT"
    }
    containers = {
      dev = {
        name = "random"
      }
    }
  }
}


