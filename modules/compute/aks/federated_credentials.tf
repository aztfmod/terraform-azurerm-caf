module "azuread_federated_credentials" {
  source   = "../../azuread/federated_credentials"
  for_each = var.settings.azuread_federated_credentials

  client_config        = var.client_config
  settings             = each.value
  azuread_applications = var.azuread_applications
  oidc_issuer_url      = azurerm_kubernetes_cluster.aks.oidc_issuer_url
}

module "mi_federated_credentials" {
  source   = "../../security/mi_federated_credentials"
  for_each = var.settings.mi_federated_credentials

  client_config      = var.client_config
  settings           = each.value
  managed_identities = var.managed_identities
  oidc_issuer_url    = azurerm_kubernetes_cluster.aks.oidc_issuer_url
  resource_group     = var.resource_group
}