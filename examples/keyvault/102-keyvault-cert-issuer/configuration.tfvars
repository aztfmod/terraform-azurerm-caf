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
  cert_secrets = {
    name                = "certsecrets"
    resource_group_key  = "kv_region1"
    sku_name            = "standard"
    soft_delete_enabled = true
        
  }
}

keyvault_certificate_issuers = {
  kv_cert_issuer = {
    issuer_name = "Dummy_issuer"
    org_id    = "ExampleOrgName"
    provider_name = "DigiCert"
    account_id = "0000"

    resource_group_key = "kv_region1"
    keyvault_key       = "cert_secrets"
  
  }
}

keyvault_access_policies = {
  # A maximum of 16 access policies per keyvault
  cert_secrets = {
    logged_in_user = {
      certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Purge", "Recover", "Getissuers", "Setissuers", "Listissuers", "Deleteissuers", "Manageissuers", "Restore", "Managecontacts"]
    }
  }
}
