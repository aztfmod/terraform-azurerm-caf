global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  rg1 = {
    name   = "dns-domain-registrar"
    region = "region1"
  }
  kv_region1 = {
    name = "kv-rg1"
  }
}

dns_zones = {
  dns_zone1 = {
    name               = "" // Set as empty for CI. this will creation a random_domain_name.com
    resource_group_key = "rg1"

    # You can create dns records using the following nested structure
    records = {
      cname = {
        www_com = {
          name   = "www"
          record = "www.bing.com"
        }
        ftp_co_uk = {
          name   = "ftp"
          record = "www.bing.co.uk"
        }
      }
    }
  }
}

domain_name_registrations = {
  #
  # Register for a random domain name
  # As dnsType as not be set
  #
  random_domain = {
    name               = "" // Set as empty for CI. this will creation a random_domain_name.com
    resource_group_key = "rg1"

    auto_renew    = true
    privacy       = true
    lock_resource = false
    dns_zone = {
      # Set the resource ID of the existing DNS zone
      # id = "/subscriptions/[subscription_id]/resourceGroups/qaxu-rg-dns-domain-registrar/providers/Microsoft.Network/dnszones/ml0iaix4xgnz0jqd.com"
      #
      # or
      #
      # Set the 'key' of the dns_zone created in this deployment
      # Set 'lz_key' if the DNS zone referenced by the key attribute has been created in a remote deployment
      key = "dns_zone1"
    }

    contacts = {
      contactAdmin = {
        name_first   = "John"
        name_last    = "Doe"
        email        = "test@contoso.com"
        phone        = "+65.12345678"
        organization = "Sandpit"
        job_title    = "Engineer"
        address1     = "Singapore"
        address2     = ""
        postal_code  = "018898"
        state        = "Singapore"
        city         = "Singapore"
        country      = "SG"
      }
      contactBilling = {
        same_as_admin = true
      }
      contactRegistrant = {
        same_as_admin = true
      }
      contactTechnical = {
        same_as_admin = true
      }
    }
  }
}

provider_azurerm_features_keyvault = {
  // set to true to cleanup the CI
  purge_soft_delete_on_destroy = true
}

keyvaults = {
  cert_secrets = {
    name               = "certsecrets"
    resource_group_key = "kv_region1"
    sku_name           = "standard"
    creation_policies = {
      logged_in_user = {
        certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Purge", "Recover", "Getissuers", "Setissuers", "Listissuers", "Deleteissuers", "Manageissuers", "Restore", "Managecontacts"]
        secret_permissions      = ["Set", "Get", "List", "Delete", "Purge"]
      }
    }

  }
}

keyvault_certificate_requests = {
  sales_application = {
    name         = "sales-application"
    keyvault_key = "cert_secrets"
    certificate_policy = {
      issuer_key_or_name  = "self"
      exportable          = true
      key_size            = 4096 // value can be 2048, 3072 or 4096
      key_type            = "RSA"
      reuse_key           = false
      renewal_action      = "AutoRenew"
      lifetime_percentage = 90
      # days_before_expiry  = 10
      content_type = "application/x-pkcs12" // application/x-pem-file

      x509_certificate_properties = {
        domain_name_registration = {
          key = "random_domain"
          # lz_key    = "random-domain-lz-key"     # Set the lz_key if the domain name registration is remote
          subdomain = "*"
        }

        subject            = "CN=sales-application"
        validity_in_months = 1
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
