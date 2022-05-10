global_settings = {
  default_region = "region1"
  regions = {
    region1 = "eastus"
  }
}
resource_groups = {
  rg1 = {
    name   = "dedicated-test"
    region = "region1"
  }
}

kusto_clusters = {
  kc1 = {
    name = "kustocluster"
    resource_group = {
      key = "rg1"
      #lz_key = ""
      #name   = ""
    }
    region = "region1"

    sku = {
      name     = "Dev(No SLA)_Standard_E2a_v4"
      capacity = 1
    }
  }
}
kusto_databases = {
  kdb1 = {
    name = "kdb1"
    resource_group = {
      key = "rg1"
      #lz_key = ""
      #name   = ""
    }
    region = "region1"
    kusto_cluster = {
      key = "kc1"
      #lz_key = ""
      #id     = ""
    }
    #hot_cache_period   = "P7D"
    #soft_delete_period = "P31D"
  }
}
