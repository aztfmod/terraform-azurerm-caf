global_settings = {
  default_region = "region1"
  regions = {
    region1 = "francecentral"
  }
}

resource_groups = {
  test = {
    name = "test"
  }
}

storage_accounts = {
  sa1 = {
    name                     = "ada9a3027eec"
    resource_group_key       = "test"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "LRS"

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

managed_identities = {
  msi01 = {
    name               = "example-msi-rolemap-msi"
    resource_group_key = "test"
  }
}

role_mapping = {
  built_in_role_mapping = {
    storage_accounts = {
      sa1 = {
        "Storage Blob Data Contributor" = {
          managed_identities = {
            keys = [
              {
                key       = "msi01",
                condition = <<EOT
                  (
                    (
                      !(ActionMatches{'Microsoft.Storage/storageAccounts/blobServices/containers/blobs/read'} AND NOT SubOperationMatches{'Blob.List'})
                    )
                    OR
                    (
                      @Resource[Microsoft.Storage/storageAccounts/blobServices/containers/blobs/tags:Malware Scanning scan result<$key_case_sensitive$>] StringEqualsIgnoreCase 'no threats found'
                    )
                  )
                EOT
              }
            ]
          },
        },
      }
    }
  }
}
