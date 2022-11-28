keyvaults = {
  ssh_keys = {
    name               = "vmsecrets"
    resource_group_key = "vm_region1"
    sku_name           = "standard"

    enabled_for_deployment = true

    creation_policies = {
      logged_in_user = {
        certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Purge", "Recover"]
        secret_permissions      = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
    }
  }
}

# Store output attributes into keyvault secret
dynamic_keyvault_secrets = {
  ssh_keys = { # Key of the keyvault
    vm-win-admin-username = {
      secret_name = "vm-win-admin-username"
      value       = "vmadmin"
    }
    vm-win-admin-password = {
      secret_name = "vm-win-admin-password"
      value       = "Very@Str5ngP!44w0rdToChaNge#"
    }
  }
}