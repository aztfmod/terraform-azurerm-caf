mi_federated_credentials = {
  cred1 = {
    name    = "mi-wi-demo01"
    subject = "system:serviceaccount:demo:workload-identity-sa"
    oidc_issuer_url = "https://westeurope.oic.prod-aks.azure.com/"
    managed_identity = {
      key = "level4"
    }
    resource_group = {
      key = "msi_region1"
    }
  }
}