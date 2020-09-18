level = "level2"

landingzone_name = "shared_services"

resource_groups = {
  primary = {
    name = "asr-sg"
  }
  secondary = {
    name = "asr-hk"
  }
}

tfstates = {
  caf_foundations = {
    tfstate = "caf_foundations.tfstate"
  }
  caf_networking = {
    tfstate = "caf_foundations.tfstate"
  }
}

recovery_vaults = {
  asr1 = {
    name = "adasass1ee"
    resource_group_key = "primary"
    
    region = "region1"

    replication_policies = {
      repl1 = {
        name = "policy1"
        resource_group_key = "primary"
        
        recovery_point_retention_in_minutes = 24*60
        application_consistent_snapshot_frequency_in_minutes = 4*60
      }
    }

    recovery_fabrics = {
      fabric1 = {
      name = "fabric-primary"
      resource_group_key = "primary"
      region = "region1"
      }
      fabric2 = {
      name = "fabric-secondary"
      resource_group_key = "secondary"
      region = "region2"
      }
    }

    protection_containers = {
      container1 = {
        name = "protection_container1"
        resource_group_key = "primary"
        recovery_fabric_key = "fabric1"
      }
      container2 = {
        name = "protection_container2"
        resource_group_key = "secondary"
        recovery_fabric_key = "fabric2"
      }
    }

    protection_container_mapping = {
      hk-sg = {
        name = "hk-sg-container-mapping"
        vault_key = "asr1"
        resource_group_key = "secondary"
        fabric_key = "fabric1"
        source_protection_container_key = "container1"
        target_protection_container_key = "container2"
        policy_key = "repl1"
      }
    } 
  }
}

network_mappings = {
  net_map1 = {
    name = "recovery-network-mapping-1"
    resource_group_key = "primary"
    recovery_vault_key = "asr1"
    source_recovery_fabric_key = "fabric1"
    target_recovery_fabric_key = "fabric2"
    # source_network = {
    #   tfstate = 
    #   key = 
    # }
    # target_network = {
    #   tfstate =
    #   key = 
    # }
  }
}

replicated_vms = {
  #TODO
}

# diagnostics = {
#           log_analytics_destination_type = "Dedicated"
#           log = [
#                       # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period] 
#                       ["AzureBackupReport", true, true, 30],
#                       ["CoreAzureBackup", true, true, 30],
#                       ["AddonAzureBackupAlerts", true, true, 30],
#                       ["AddonAzureBackupJobs", true, true, 30],
#                       ["AddonAzureBackupPolicy", true, true, 30],
#                       ["AddonAzureBackupProtectedInstance", true, true, 30],
#                       ["AddonAzureBackupStorage", true, true, 30],
#                       ["AzureSiteRecoveryJobs", true, true, 30],
#                       ["AzureSiteRecoveryEvents", true, true, 30],
#                       ["AzureSiteRecoveryReplicatedItems", true, true, 30],
#                       ["AzureSiteRecoveryReplicationStats", true, true, 30],
#                       ["AzureSiteRecoveryRecoveryPoints", true, true, 30],
#                       ["AzureSiteRecoveryReplicationDataUploadRate", true, true, 30],
#                       ["AzureSiteRecoveryProtectedDiskDataChurn", true, true, 30],
#               ]
#           metric = [
#                   #["AllMetrics", 60, True],
#           ]
#       }