global_settings = {
  default_region = "region1"
  regions = {
    region1 = "eastus2"
    region2 = "centralus"
  }
}

resource_groups = {
  aks_re1 = {
    name   = "aks-re1"
    region = "region1"
  }
  aks_re2 = {
    name   = "aks-re2"
    region = "region2"
  }
}



#
role_mapping = {
  custom_role_mapping = {}

  built_in_role_mapping = {
    azure_container_registries = {
      acr1 = {
        "AcrPull" = {
          aks_clusters = {
            keys = ["cluster_re1", "cluster_re2"]
          }
        }
      }
    }
  }
}