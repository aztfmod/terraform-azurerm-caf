global_settings = {
  default_region = "region1"
  regions = {
    region1 = "eastus"
    region2 = "australiacentral"
  }
}

resource_groups = {
  aro1 = {
    name   = "aro-test"
    region = "region1"
  }
}

aro_clusters = {
  aro1 = {
    name               = "aro"
    resource_group_key = "aro1"

    service_principal = {
      key = "sp1"
      keyvault = {
        key           = "test_client"
        secret_prefix = "test-client"
      }
      ## support for litterals
      # client_id = ""
      # client_secret = ""
      # # {
    }

    api_server_profile = {
      visibility = "Private"
    }

    ingress_profiles = [
      {
        name       = "default"
        visibility = "Private"
      }
    ]


    cluster_profile = {
      domain                 = "testcafaro43"
      fips_validated_modules = "Disabled"
      # pull_secret = {
      #  secret           = "your_secret"
      #  secret_id        = "resource_id_of_the_secret"
      #}
      version = "4.13.23"
      resource_group = {
        # cant be an existing RG, you can specify the name of the RG to create with id="" or just a name=""
        # id = "resource_group_id"
        name = "test-aro"
      }
    }

    master_profile = {
      vm_size            = "Standard_D8s_v3"
      encryption_at_host = "Disabled"
      subnet = {
        key = "subnet1"
        vnet = {
          key = "vnet1"
        }
        //id = "resource_id"
      }
      # disk_encryption_set = {
      #   key = "disk-encryption-set1"
      #   id = "resource_id"
      # }
    }

    worker_profiles = [
      {
        name               = "worker"
        vm_size            = "Standard_D4s_v3"
        disk_size_gb       = "128"
        node_count         = "4"
        encryption_at_host = "Disabled"
        subnet = {
          key = "subnet2"
          vnet = {
            key = "vnet1"
          }
          //id = "resource_id"
        }
      }
    ]

    network_profile = {
      pod_cidr     = "10.128.0.0/14"
      service_cidr = "172.30.0.0/16"
    }

  }
}
