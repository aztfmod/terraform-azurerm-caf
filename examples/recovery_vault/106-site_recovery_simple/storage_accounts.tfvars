storage_accounts = {
  recovery_cache_primary = {
    name = "primaryrecoverycache"
    # This option is to enable remote RG reference
    # resource_group = {
    #   lz_key = ""
    #   key    = ""
    # }

    resource_group_key = "primary"
    # Account types are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Defaults to StorageV2
    account_kind = "BlobStorage"
    # Account Tier options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid.
    account_tier = "Standard"
    #  Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS
    account_replication_type = "LRS" # https://docs.microsoft.com/en-us/azure/storage/common/storage-redundancy
    # tags = {
    #   environment = "dev"
    #   team        = "IT"
    #   ##
    # }
    # containers = {
    #   dev = {
    #     name = "random"
    #   }
    # }

    # enable_system_msi = true
    # customer_managed_key = {
    #   keyvault_key = "stg_byok"

    #   # Reference to the var.keyvault_keys
    #   keyvault_key_key = "byok"
    # }
  }
}