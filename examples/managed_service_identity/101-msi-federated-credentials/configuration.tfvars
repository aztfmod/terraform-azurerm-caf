
global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  msi_region1 = {
    name   = "security-rg1"
    region = "region1"
  }
  msi_lz = {
    name   = "security-rg1"
    region = "region1"
  }
  cluster = {
    name   = "cluster-rg1"
    region = "region1"
  }
}

managed_identities = {
  poc = {
    name            = "poc-mi"
    resource_group  = {
      key     = "msi_region1"
      #lz_key  = ""
    }
    federated_credential = {
      dev = {
        name        = "some_name"
        aks_cluster = {
          key             = "cluster_re1"
          #lz_key          = ""
        }
        kubernetes  = {
          service_account  = "backend"
          namespace        = "apis"
        }
      }
      qa = {
        name        = "testing"
        aks_cluster = {
          key     = "cluster_re1"
        }
        subject = "system:serviceaccount:default:qa"
      }
    }
  }
  site = {
    name                = "databases"
    resource_group_key  = "msi_lz"
    federated_credential = {
      manual = {
        name        = "happy_rabbit"
        issuer      = "https://westeurope.oic.dev-cluster.azure.com/652ea6e0-593d-4ec5-1f63-171b4d354180/eeaa8533-ad54-4106-9b8b-c389480b31e7/"
        kubernetes  ={
          service_account  = "backend"
          namespace        = "apis"
        }
      }
    }
  }
}
