# self-signed certs in the key vault
# for better description of keyvault_certificates object see: examples/app_gateway/210-agw-with-keyvault/certificates.tfvars
keyvault_certificates = {
  "demoapp1.cafdemo.com" = {
    keyvault_key       = "kv1"
    name               = "demoapp1-cafdemo-com"
    subject            = "CN=demoapp1"
    validity_in_months = 12
    subject_alternative_names = {
      dns_names = [
        "demoapp1.cafdemo.com"
      ]
    }
    tags = {
      type = "SelfSigned"
    }
    issuer_parameters  = "Self"
    exportable         = true
    key_size           = 4096
    key_type           = "RSA"
    reuse_key          = true
    action_type        = "AutoRenew"
    days_before_expiry = 30
    content_type       = "application/x-pkcs12"
    key_usage = [
      "cRLSign",
      "dataEncipherment",
      "digitalSignature",
      "keyAgreement",
      "keyCertSign",
      "keyEncipherment",
    ]
  }
  "demoapp2.cafdemo.com" = {
    keyvault_key       = "kv1"
    name               = "demoapp2-cafdemo-com"
    subject            = "CN=demoapp2"
    validity_in_months = 12
    subject_alternative_names = {
      dns_names = [
        "demoapp2.cafdemo.com"
      ]
    }
    tags = {
      type = "SelfSigned"
    }
    issuer_parameters  = "Self"
    exportable         = true
    key_size           = 4096
    key_type           = "RSA"
    reuse_key          = true
    action_type        = "AutoRenew"
    days_before_expiry = 30
    content_type       = "application/x-pkcs12"
    key_usage = [
      "cRLSign",
      "dataEncipherment",
      "digitalSignature",
      "keyAgreement",
      "keyCertSign",
      "keyEncipherment",
    ]
  }
}
