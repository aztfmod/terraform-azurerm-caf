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
  kc_node0 = {
    name = "kustocluster1_node0"
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
  kc_node1 = {
    name = "kustocluster1_node1"
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
  db1_node0 = {
    name = "kdb1"
    resource_group = {
      key = "rg1"
      #lz_key = ""
      #name   = ""
    }
    region = "region1"
    kusto_cluster = {
      key = "kc_node0"
      #lz_key = ""
      #id     = ""
    }
    #hot_cache_period   = "P7D"
    #soft_delete_period = "P31D"
  }
  db1_node1 = {
    name = "kdb1"
    resource_group = {
      key = "rg1"
      #lz_key = ""
      #name   = ""
    }
    region = "region1"
    kusto_cluster = {
      key = "kc_node1"
      #lz_key = ""
      #id     = ""
    }
    #hot_cache_period   = "P7D"
    #soft_delete_period = "P31D"
  }
}

kusto_attached_database_configurations = {
  db1_config = {
    name = "kadc1"
    resource_group = {
      key = "rg1"
      #lz_key = ""
      #name   = ""
    }
    region = "region1"
    kusto_cluster = {
      source = {
        key = "kc_node0"
      }
      destination = {
        key = "kc_node1"
      }
      #lz_key = ""
      #id     = ""
    }
    kusto_database = {
      key = "db1_node1"
      #lz_key = ""
      # name   = "db_node1"
    }
    default_principal_modifications_kind = "None"
  }
}