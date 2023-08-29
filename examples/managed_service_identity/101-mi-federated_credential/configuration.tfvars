resource_groups = {
  msi_region1 = {
    name   = "security-rg1"
    region = "region1"
  }
}

managed_identities = {
  workload_system_mi = {
    name               = "demo-mi-wi"
    resource_group_key = "msi_region1"
  }
}

mi_federated_credentials = {
  cred1 = {
    name            = "mi-wi-demo01"
    subject         = "system:serviceaccount:demo:workload-identity-sa"
    oidc_issuer_url = "https://westeurope.oic.prod-aks.azure.com/"
    managed_identity = {
      key = "workload_system_mi"
    }
    resource_group = {
      key = "msi_region1"
    }
  }
}