global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}

provider_azurerm_features_keyvault = {
  // set to true to cleanup the CI
  purge_soft_delete_on_destroy = true
}

resource_groups = {
  kv_region1 = {
    name = "example-rg1"
  }
}

keyvaults = {
  cert_secrets = {
    name               = "certsecrets"
    resource_group_key = "kv_region1"
    sku_name           = "standard"
    # cert_password_key  = "cert-password"
    creation_policies = {
      logged_in_user = {
        certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Purge", "Recover", "Getissuers", "Setissuers", "Listissuers", "Deleteissuers", "Manageissuers", "Restore", "Managecontacts"]
        secret_permissions      = ["Set", "Get", "List", "Delete", "Purge"]
      }
    }

  }
}

keyvault_certificate_requests = {
  domain1 = {
    name         = "domain1"
    keyvault_key = "cert_secrets"
    certificate_policy = {
      issuer_key_or_name  = "self"
      exportable          = true
      key_size            = 4096 // value can be 2048, 3072 or 4096
      key_type            = "RSA"
      reuse_key           = false
      renewal_action      = "EmailContacts"
      lifetime_percentage = 90
      # days_before_expiry  = 10
      content_type = "application/x-pkcs12" // application/x-pem-file

      x509_certificate_properties = {

        # Refer to the documentation step to adjust the public dns domain name setup in internet_domain_name.tfvars
        domain_name_registration = {
          key       = "domain1"
          lz_key    = "example-domain-lz-key"
          subdomain = "*"
        }
        validity_in_months = 12
        key_usage          = ["keyCertSign"]
        subject_alternative_names = {
          dns_names = []
          emails    = []
          upns      = []
        }
      }
    }
  }
}