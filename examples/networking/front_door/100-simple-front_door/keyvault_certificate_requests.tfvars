keyvault_certificate_requests = {
  crm_application = {
    name         = "crm-application"
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
        subject            = "CN=crm-application"
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