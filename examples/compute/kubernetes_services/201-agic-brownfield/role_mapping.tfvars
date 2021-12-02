role_mapping = {
  built_in_role_mapping = {
    resource_groups = {
      "aks_re1" = {
        "Reader" = {
          aks_ingress_application_gateway_identities = {
            keys = ["cluster_re1"]
          }
        }
      }
    }
    application_gateway_platforms = {
      "agw" = {
        "Contributor" = {
          aks_ingress_application_gateway_identities = {
            keys = ["cluster_re1"]
          }
        }
      }
    }
    managed_identities = {
      "aks_usermsi" = {
        "Managed Identity Operator" = {
          aks_ingress_application_gateway_identities = {
            keys = ["cluster_re1"]
          }
        }
      }
    }
  }
}
