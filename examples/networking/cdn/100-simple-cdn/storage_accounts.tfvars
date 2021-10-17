storage_accounts = {

  example_storage_account_key = {
    name                     = "examplestorageaccount"
    resource_group_key       = "cdn_profile_example_key"
    account_kind             = "StorageV2" # Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Defaults to StorageV2
    account_tier             = "Standard"  # Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid
    account_replication_type = "LRS"       # https://docs.microsoft.com/en-us/azure/storage/common/storage-redundancy
    min_tls_version          = "TLS1_2"    # Possible values are TLS1_0, TLS1_1, and TLS1_2. Defaults to TLS1_0 for new storage accounts.
    allow_blob_public_access = false
    is_hns_enabled           = false

    static_website = {
      index_document     = "index.html"
      error_404_document = "index.html"
    }

    tags = {
      team = "Example tag"
    }

    containers = {}
  }

}