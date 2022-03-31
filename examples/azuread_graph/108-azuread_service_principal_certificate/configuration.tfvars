azuread_applications = {
  app1 = {
    display_name = "example"
  }
}
azuread_service_principals = {
  sp1 = {
    application = {
      key = "app1"
    }
  }
}
azuread_service_principal_certificates = {
  spc1 = {
    service_principal = {
      key = "sp1"
    }
    type     = "AsymmetricX509Cert"
    value    = "./azuread_graph/108-azuread_service_principal_certificate/cert/cert.pem"
    end_date = "2021-05-01T01:02:03Z"
  }
}