azuread_applications = {
  aks_auth_app = {
    application_name = "app-najeeb-sandbox-aksadmin"
  }
}

azuread_federated_credentials = {
  cred1 = {
    display_name    = "app-wi-fed01"
    subject         = "system:serviceaccount:demo:workload-identity-sa"
    oidc_issuer_url = "https://westeurope.oic.prod-aks.azure.com/"
    azuread_application = {
      key = "aks_auth_app"
    }
  }
}

azuread_service_principals = {
  aks_auth_app = {
    azuread_application = {
      key = "aks_auth_app"
    }
  }
}