global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  dac_test = {
    name = "rg-databricks-access-connectors"
  }
}

databricks_access_connectors = {
  dac_1 = {
    name               = "example-name"
    resource_group_key = "dac_test"
    identity = {
      type                  = "UserAssigned" #SystemAssigned
      managed_identity_keys = ["dac_test"]
    }
    tags = {
      test  = "test"
      test1 = "test1"
    }
  }
}

managed_identities = {
  dac_test = {
    name               = "mi-dac-test"
    resource_group_key = "dac_test"
  }
}
