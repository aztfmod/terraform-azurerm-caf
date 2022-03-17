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

    identity = {
      type                  = "UserAssigned"
      managed_identity_keys = ["mi1"]
    }

    sku_name = "Developer_1"
  }
}

keyvaults = {
  kv1 = {
    name               = "certs"
    resource_group_key = "rg1"
    sku_name           = "standard"

    enabled_for_deployment = true

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
    apgw_keyvault_secrets = {
      managed_identity_key    = "mi1"
      certificate_permissions = ["Get", "List"]
      secret_permissions      = ["Get", "List"]
    }
  }
}


api_management_certificate = {
  apimc1 = {
    name = "example-cert"
    api_management = {
      key = "apim1"
    }
    resource_group = {
      key = "rg1"
    }
    key_vault_secret = {
      certificate_key = "cert1"
    }
    key_vault_identity_client = {
      key = "mi1"
    }
  }
}