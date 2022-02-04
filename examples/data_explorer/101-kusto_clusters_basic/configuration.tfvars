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