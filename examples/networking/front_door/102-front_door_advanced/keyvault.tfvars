keyvaults = {
  cert_secrets = {
    name               = "certsecrets"
    resource_group_key = "front_door"
    sku_name           = "standard"
    creation_policies = {
      logged_in_user = {
        certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Purge", "Recover", "Getissuers", "Setissuers", "Listissuers", "Deleteissuers", "Manageissuers", "Restore", "Managecontacts"]
        secret_permissions      = ["Set", "Get", "List", "Delete", "Purge"]
      }
    }
  }
}

# Store output attributes into keyvault secret
dynamic_keyvault_secrets = {
  cert_secrets = { # Key of the keyvault
    cert-password = {
      secret_name = "cert-password"
      value       = "Very@Str5ngP!44w0rdToChaNge#"
    }
  }
}

keyvault_certificate_issuers = {
  kv_cert_issuer = {
    issuer_name        = "DummyIssuer"
    provider_name      = "DigiCert"
    organization_id    = "ExampleOrg"
    account_id         = "0000"
    resource_group_key = "front_door"
    keyvault_key       = "cert_secrets"
    cert_password_key  = "cert-password"

    admin_settings = {
      admin1 = {
        first_name    = "cert-admin1"
        last_name     = "cert-admin1-last-name"
        email_address = "email1@domain.net"
        phone_number  = "00000000"
      } #remove the following block if additional adminss aren't needed.
      admin2 = {
        first_name    = "cert-admin2"
        last_name     = "cert-admin2-last-name"
        email_address = "email2@domain.net"
        phone_number  = "00000001"
      }
    } #add more admins by repeating the block.
  }
}
