global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
    region2 = "australiacentral"
  }
}

resource_groups = {
  primary = {
    name   = "sharedsvc_re1"
    region = "region1"
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
    }

    protection_containers = {
      container1 = {
        name                = "protection_container1"
        resource_group_key  = "primary"
        recovery_fabric_key = "fabric1"
      }
    }

  }
}