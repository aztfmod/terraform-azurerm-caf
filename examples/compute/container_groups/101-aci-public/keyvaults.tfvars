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
      rover_msi = {
        managed_identity_key    = "rover"
        secret_permissions      = ["Get"]
      }
    }
  }
}

# Store output attributes into keyvault secret
dynamic_keyvault_secrets = {
  secrets = { 
    admin = {
      secret_name = "azdo-pat-admin"
      value       = ""
    }
    agent = {
      secret_name = "azdo-pat-agent"
      value       = "vbhv2gwmtjo6owsxeehxlm3ivuv6wqu2pubyrhlckde3su2dtsdq"
    }
  }
}