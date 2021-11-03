frontdoor_custom_https_configuration = {
  fchc1 = {
    frontend_endpoint              =  {
      id = ""
      #front_door_key = ""
      #name = ""
      #lz_key = ""
    }
    custom_https_provisioning_enabled = true
    custom_https_configuration  = {
      certificate_source                      = "AzureKeyVault"
      azure_key_vault_certificate_secret_name = "examplefd1"
      azure_key_vault_certificate_vault_id    = data.azurerm_key_vault.vault.id
    }
  }
}
