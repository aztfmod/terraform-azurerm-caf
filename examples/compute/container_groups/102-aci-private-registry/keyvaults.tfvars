keyvaults = {
  secrets = {
    name               = "secrets"
    resource_group_key = "rg1"
    sku_name           = "standard"

    enabled_for_deployment = true

    creation_policies = {
      logged_in_user = {
        certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Purge", "Recover"]
        secret_permissions      = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
      github_private_image = {
        managed_identity_key = "github_private_image"
        secret_permissions   = ["Get"]
      }
    }
  }
}

# Store output attributes into keyvault secret
dynamic_keyvault_secrets = {
  secrets = { # Key of the keyvault
    ghcr_username = {
      secret_name = "image-registry-username"
      value       = "my_username"
    }
    ghcr_password = {
      secret_name = "image-registry-password"
      value       = "replace with GitHub PAT"
    }
  }
}
