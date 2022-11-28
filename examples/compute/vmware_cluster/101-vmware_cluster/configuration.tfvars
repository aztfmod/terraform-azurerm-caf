global_settings = {
  default_region = "region1"
  regions = {
    region1 = "eastus2"
  }
}

resource_groups = {
  rgvwc = {
    name   = "vmwarecluster-test"
    region = "region1"
  }
}

keyvaults = {
  kv_rg1 = {
    name               = "kv1"
    resource_group_key = "rgvwc"
    sku_name           = "standard"

    creation_policies = {
      logged_in_user = {
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge"]
      }
    }
  }
}

dynamic_keyvault_secrets = {
  kv_rg1 = { # Key of the keyvault
    secret_key1 = {
      secret_name = "nsxt-password"
      value       = "123#sadd$saASD"
    }
    secret_key2 = {
      secret_name = "vcenter-password"
      value       = "123#sadd$saASD"
    }
  }
}

vmware_private_clouds = {
  vwpc1 = {
    name               = "example-vmware-private-cloud"
    resource_group_key = "rgvwc"
    region             = "region1"
    sku_name           = "av36"
    management_cluster = {
      size = 3
    }
    network_subnet_cidr         = "192.168.48.0/22"
    internet_connection_enabled = false

    nsxt_password = {
      #password = "123#sadd$saASD"
      keyvault_key = "kv_rg1"
      #lz_key= "ejkle" (optional)
      secret_key = "secret_key1"
    }
    vcenter_password = {
      keyvault_key = "kv_rg1"
      #lz_key= "ejkle" (optional)
      secret_name = "vcenter-password"
    }
  }
}

vmware_clusters = {
  vwc1 = {
    name                     = "example-Cluster"
    vmware_private_cloud_key = "vwpc1"
    cluster_node_count       = 3
    sku_name                 = "av36"
  }
}