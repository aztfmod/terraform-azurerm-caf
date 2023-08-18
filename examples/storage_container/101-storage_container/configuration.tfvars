global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

var_folder_path = "storage_container/101-storage_container"

resource_groups = {
  test = {
    name = "rg1"
  }
}

# https://docs.microsoft.com/en-us/azure/storage/
storage_accounts = {
  sa1 = {
    name                     = "sa1"
    resource_group_key       = "test"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }
}



storage_containers = {
  scripts = {
    name = "scripts"
    storage_account = {
      key = "sa1"
    }
    container_access_type = "private"
  }
}


role_mapping = {
  built_in_role_mapping = {
    storage_containers = {
      scripts = {
        "Storage Blob Data Contributor" = {
          logged_in = {
            keys = ["user"]
          }
        }
        "Storage Blob Data Reader" = {
          managed_identities = {
            keys = ["msi1"]
          }
        }
      }
    }
  }
}

# Attributes available https://www.terraform.io/docs/providers/azurerm/r/storage_blob.html
storage_account_blobs = {
  devops_runtime_docker = {
    storage_account_key = "sa1"
    storage_container = {
      key = "scripts"
    }
    name = "devops_runtime_docker.sh"
    #
    # Note this source path has to be the full path or
    # the relative path to the module variable var_folder_path
    # So when running terraform add -var var_folder_path={base path of the source attribute}
    #
    source = "scripts/devops_runtime_docker.sh"

    delay = {
      create_duration = "30s"
    }
  }
  devops_runtime_docker_by_content = {
    storage_account_key = "sa1"
    storage_container = {
      key = "scripts"
    }
    name           = "devops_runtime_docker_content.sh"
    source_content = <<-EOF
    #!/bin/bash
    echo "Hello world"
    EOF

    delay = {
      create_duration = "30s"
    }
  }
}


managed_identities = {
  msi1 = {
    name = "msi"
    resource_group = {
      key = "test"
    }
  }
}
