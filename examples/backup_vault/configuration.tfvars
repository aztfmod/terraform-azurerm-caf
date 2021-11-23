backup_vaults = {
  bv0 = {
    name               = "bckp-level0"
    resource_group_key = "level0"
    datastore_type     = "VaultStore"   #Valid options are ArchiveStore, SnapshotStore and VaultStore
    redundancy         = "GeoRedundant" #Valid options are GeoRedundant and LocallyRedundant
    #Optional identity block
    enable_identity = {
      type = "SystemAssigned"
    }
  }
}
