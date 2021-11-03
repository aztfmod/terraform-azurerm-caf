frontdoor_custom_https_configuration = {
  frontend_endpoint_id              = azurerm_frontdoor.example.frontend_endpoints["exampleFrontendEndpoint2"]
  custom_https_provisioning_enabled = true

  custom_https_configuration {
    certificate_source                      = "AzureKeyVault"
    azure_key_vault_certificate_secret_name = "examplefd1"
    azure_key_vault_certificate_vault_id    = data.azurerm_key_vault.vault.id
  }
}




​
