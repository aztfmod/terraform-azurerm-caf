azuread_federated_credentials = {
  cred1 = {
    display_name = "app-wi-fed01"
    subject = "system:serviceaccount:demo:workload-identity-sa"
    oidc_issuer_url = "https://westeurope.oic.prod-aks.azure.com/"
    azuread_application = {
      key = "test_client_v1"
    }
  }
}