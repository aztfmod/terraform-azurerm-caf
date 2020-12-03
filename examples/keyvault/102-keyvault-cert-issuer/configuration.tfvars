global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}

resource_groups = {
  kv_region1 = {
    name = "example-rg1"
  }
}

keyvaults = {
  example_rg1 = {
    name               = "kvsecrets"
    resource_group_key = "kv_region1"
    sku_name           = "standard"
  }
}

keyvault_certificate_issuers = {
  kv_cert_issuer = {
    name = "testing"
    org_id        = "ExampleOrgName"
    resource_group_key = "kv_region1"
    keyvault_key       = "key-rg1"

  }
}

keyvault_access_policies = {
  # A maximum of 16 access policies per keyvault
  example_kv_rg1 = {
    logged_in_user = {
      secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
    }
    logged_in_aad_app = {
      secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
    }
  }
}
