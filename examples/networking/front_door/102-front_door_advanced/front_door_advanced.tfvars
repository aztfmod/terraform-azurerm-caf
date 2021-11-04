frontdoor_custom_https_configuration = {
  fchc1 = {
    frontend_endpoint = {
      #id = ""
      front_door_key = "front_door1"
      name           = "exampleFrontendEndpoint1"
    }
    custom_https_provisioning_enabled = true
    custom_https_configuration = {
      certificate_source = "FrontDoor" #FrontDoor or AzureKeyVault.
      #keyvault = {
      #  #id = ""
      #  key = "cert_secrets"
      #  #lz_key = ""
      #  secret_name = "cert-admin1"
      #  #secret_version = ""
      #}
    }
  }
}
