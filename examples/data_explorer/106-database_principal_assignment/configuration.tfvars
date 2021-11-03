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
azuread_applications = {
  test_client = {
    useprefix        = true
    application_name = "test-client"
  }
}
azuread_service_principals = {
  sp1 = {
    azuread_application = {
      key = "test_client"
    }
    app_role_assignment_required = true
  }
}

kusto_database_principal_assignments = {
  kdpa1 = {
    name = "KustoPrincipalAssignment"
    resource_group = {
      key = "rg1"
      #lz_key = ""
      #name   = ""
    }
    kusto_cluster = {
      key = "kc1"
      #lz_key = ""
      #id     = ""
    }
    database = {
      key = "kdb1"
      #lz_key = ""
      #name   = ""
    }
    kusto_cluster = {
      key = "kc1"
      #lz_key = ""
      #id     = ""
    }
    principal = {
      key = "sp1"
      #lz_key = ""
      #id   = ""
      #tenant_id   = ""
    }
    principal_type = "App"
    role           = "Viewer"
  }
}