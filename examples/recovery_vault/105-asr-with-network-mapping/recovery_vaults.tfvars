recovery_vaults = {
  asr1 = {
    name               = "vault_re1"
    resource_group_key = "primary"
    region             = "region1"
    vnet_key           = "vnet_region1"
    subnet_key         = "asr_subnet"

    soft_delete_enabled = false

    replication_policies = {
      repl1 = {
        name               = "policy1"
        resource_group_key = "primary"

        recovery_point_retention_in_minutes                  = 24 * 60
        application_consistent_snapshot_frequency_in_minutes = 4 * 60
      }
    }

    recovery_fabrics = {
      fabric1 = {
        name               = "fabric-primary"
        resource_group_key = "primary"
        region             = "region1"
      }
      fabric2 = {
        name               = "fabric-secondary"
        resource_group_key = "secondary"
        region             = "region2"
      }
    }

    protection_containers = {
      container1 = {
        name                = "protection_container1"
        resource_group_key  = "primary"
        recovery_fabric_key = "fabric1"
      }
      container2 = {
        name                = "protection_container2"
        resource_group_key  = "secondary"
        recovery_fabric_key = "fabric2"
      }
    }

    protection_container_mapping = {
      hk-sg = {
        name                            = "hk-sg-container-mapping"
        vault_key                       = "asr1"
        resource_group_key              = "primary"
        fabric_key                      = "fabric1"
        source_protection_container_key = "container1"
        target_protection_container_key = "container2"
        policy_key                      = "repl1"
      }
    }

    network_mappings = {
      sghk = {
        name                       = "fabric-asr"
        resource_group_key         = "primary"
        region                     = "region1"
        vault_key                  = "asr1"
        source_recovery_fabric_key = "fabric1"
        target_recovery_fabric_key = "fabric2"
        source_network = {
          #lz_key   = ""
          vnet_key = "vnet_region1"
          #id=Use the vnet id to use a network created outside of CAF
        }
        target_network = {
          #lz_key   = ""
          vnet_key = "vnet_region2"
          #id= "/subscriptions/********/resourceGroups/********/providers/Microsoft.Network/virtualNetworks/vnet-********-sandbox-asr"
        }
      }

    }

    backup_policies = {
      vms = {
        policy1 = {
          name      = "VMBackupPolicy1"
          vault_key = "asr1"
          rg_key    = "primary"
          timezone  = "UTC"
          backup = {
            frequency = "Daily"
            time      = "23:00"
            #if not desired daily, can pick weekdays as below:
            #weekdays  = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
          }
          retention_daily = {
            count = 10
          }
          retention_weekly = {
            count    = 42
            weekdays = ["Sunday", "Wednesday", "Friday", "Saturday"]
          }
          retention_monthly = {
            count    = 7
            weekdays = ["Sunday", "Wednesday"]
            weeks    = ["First", "Last"]
          }
          retention_yearly = {
            count    = 77
            weekdays = ["Sunday"]
            weeks    = ["Last"]
            months   = ["January"]
          }
        }
      }

      fs = {
        policy1 = {
          name      = "FSBackupPolicy1"
          vault_key = "asr1"
          rg_key    = "primary"
          timezone  = "UTC"
          backup = {
            frequency = "Daily"
            time      = "23:00"
          }
          retention_daily = {
            count = 10
          }
        }
      }
    }

  }
}