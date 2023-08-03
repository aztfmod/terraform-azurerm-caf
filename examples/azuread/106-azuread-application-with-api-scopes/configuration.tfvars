global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
  random_length = 5
}

azuread_applications = {
  test_client = {
    useprefix        = true
    application_name = "test-client"
    api = {
      mapped_claims_enabled          = true
      requested_access_token_version = 2

      # known_client_applications = [
      #   "someID"
      # ]

      oauth2_permission_scopes = [
        {
          admin_consent_description  = "Allow to administer app."
          admin_consent_display_name = "Administer app"
          enabled                    = true
          # Generate UUID: uuidgen | tr "[:upper:]" "[:lower:]"
          id    = "0f667d11-5c49-486e-a4f6-b1eb5fc1e25b"
          type  = "Admin"
          value = "app"
        }
      ]
    }
  }
}
