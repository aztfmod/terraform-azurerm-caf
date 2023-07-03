storage_accounts = {
  scripts = {
    name                      = "scripts"
    resource_group_key        = "agents"
    account_kind              = "StorageV2"
    account_tier              = "Standard"
    shared_access_key_enabled = false
    account_replication_type  = "LRS"
    allow_blob_public_access  = false
  }
}
storage_containers = {
  scripts = {
    name = "scripts"
    storage_account = {
      key = "scripts"
    }
    container_access_type = "private"
  }
}

storage_account_blobs = {
  devops_runtime_baremetal = {
    storage_account_key    = "scripts"
    storage_container_name = "scripts"
    name                   = "devops_runtime_baremetal.sh"
    source                 = "scripts/devops_runtime_baremetal.sh"
  }
  tfcloud_selfhosted_agent = {
    storage_account_key    = "scripts"
    storage_container_name = "scripts"
    name                   = "tfcloud_selfhosted_agent.sh"
    source                 = "scripts/tfcloud_selfhosted_agent.sh"
  }
}