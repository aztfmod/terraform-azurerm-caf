global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
    region2 = "eastasia"
  }
}

resource_groups = {
  primary = {
    name = "sharedsvc_re1"
    region = "region1"
  }
  primary = {
    name = "sharedsvc_re2"
    region = "region2"
  }
}

recovery_vaults = {
  asr1 = {
    name               = "vault_re1"
    resource_group_key = "primary"

    region = "region1"

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
      re1-re2 = {
        name                            = "re1-re2-container-mapping"
        vault_key                       = "asr1"
        resource_group_key              = "secondary"
        fabric_key                      = "fabric1"
        source_protection_container_key = "container1"
        target_protection_container_key = "container2"
        policy_key                      = "repl1"
      }
    }
}
}