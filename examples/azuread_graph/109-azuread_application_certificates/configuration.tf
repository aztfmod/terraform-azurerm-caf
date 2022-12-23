azuread_applications = {
  app1 = {
    application_name     = "example"
    identifier_uris  = ["api://test-external-example-app"]
    sign_in_audience = "AzureADMultipleOrgs"
  }
}

resource_groups = {
  rg1 = {
    name   = "example"    
  }
}

/******************************************************************************
*** Create Key Vault
******************************************************************************/
keyvaults = {
  kv1 = {
    name                       = "example"
    resource_group_key         = "rg1"
    soft_delete_retention_days = 90
  }
}

keyvault_certificates = {    
  kvc1 = {
    name                = "AppCertificate"
    keyvault_key        = "kv1"
    issuer_parameters   = "Self"
    exportable          = true
    key_size            = 2048
    key_type            = "RSA"
    reuse_key           = false
    action_type         = "EmailContacts"
    lifetime_percentage = 80
    subject             = "CN=app-certificate"
    subject_alternative_names = {
      dns_names = []
    }
    content_type = "application/x-pkcs12"
    key_usage = [
      "digitalSignature",
      "keyEncipherment"
    ]
    validity_in_months = 12
  }
}

azuread_application_certificates = {
  appc1 = {
    application_object = {
      key = "app1"
    }
    encoding = "hex"
    keyvault_certificate = {
      key = "kvc1"
    }
    type = "AsymmetricX509Cert"
  }
}
