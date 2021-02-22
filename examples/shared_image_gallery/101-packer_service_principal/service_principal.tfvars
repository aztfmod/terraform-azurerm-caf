azuread_apps = {
  packer_client = {
    useprefix                    = true
    application_name             = "packer-client"
    password_expire_in_days      = 1
    app_role_assignment_required = true
    keyvaults = {
      packer_client = {
        secret_prefix = "packer-client"
      }
    }
    # Store the ${secret_prefix}-client-id, ${secret_prefix}-client-secret...
    # Set the policy during the creation process of the launchpad
  }
}