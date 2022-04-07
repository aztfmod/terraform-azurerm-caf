global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  rg1 = {
    name   = "example-agw"
    region = "region1"
  }
}
managed_identities = {
  mi1 = {
    name               = "secrets-msi"
    resource_group_key = "rg1"
  }
}

api_management = {
  apim1 = {
    name   = "example-apim"
    region = "region1"
    resource_group = {
      key = "rg1"
    }
    publisher_name  = "My Company"
    publisher_email = "company@terraform.io"

    sku_name = "Developer_1"

    identity = {
      type                  = "UserAssigned"
      managed_identity_keys = ["mi1"]
    }
  }
}


keyvaults = {
  kv1 = {
    name               = "certs"
    resource_group_key = "rg1"
    sku_name           = "standard"

    creation_policies = {
      logged_in_user = {
        certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Purge", "Recover"]
        secret_permissions      = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
    }
  }
}

keyvault_access_policies = {
  kv1 = {
    mi1 = {
      managed_identity_key    = "mi1"
      certificate_permissions = ["Get", "List"]
      secret_permissions      = ["Get", "List"]
    }
  }
}

api_management_custom_domain = {
  apimcd1 = {
    api_management = {
      key = "apim1"
    }
    proxy = {
      host_name = "api.example.com"
      key_vault_certificate = {
        certificate_request_key = "example"
      }
    }

    developer_portal = {
      host_name = "portal.example.com"
      key_vault_certificate = {
        certificate_request_key = "example"
        #id = ""
      }
    }
  }
}