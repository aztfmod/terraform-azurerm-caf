global_settings = {
  default_region = "region1"
  regions = {
    region1 = "uksouth"
  }
}

resource_groups = {
  load-test-region1 = {
    name   = "load-test-rg"
    region = "region1"
  }
}

load_test = {
  example_load_test = {
    name               = "example-load-test"
    resource_group_key = "load-test-region1"
    identity = {
      type                  = "UserAssigned"
      managed_identity_keys = ["load_test"]
    }
  }
}

managed_identities = {
  load_test = {
    name = "load-test"
    resource_group = {
      key = "load-test-region1"
    }
  }
}
