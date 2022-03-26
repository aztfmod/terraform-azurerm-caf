# key vault to store certificates that VMs will pull from
keyvaults = {
  kv1 = {
    name               = "vmcerts"
    resource_group_key = "rg1"
    sku_name           = "standard"
    #enabled_for_deployment = true
    creation_policies = {
      logged_in_user = {
        # policy to access secrets (required retrieve the admin credentials to RDP into VMs)
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
        # need policy so current user can mange certificates in this key vault
        certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Purge", "Recover", "Getissuers", "Setissuers", "Listissuers", "Deleteissuers", "Manageissuers", "Restore", "Managecontacts"]
      }
    }
  }
}
# generate admin account credentials and put in keyvault
# this way all VMs will use the same credentials
dynamic_keyvault_secrets = {
  kv1 = {
    admin-username = {
      secret_name = "admin-username"
      value       = "adminuser"
    }
    admin-password = {
      secret_name = "admin-password"
      value       = "dynamic"
      config = {
        length           = 25
        special          = true
        override_special = "_!@"
      }
    }
  }
}
# managed identity associated with vm
managed_identities = {
  vm_msi = {
    name               = "vm"
    resource_group_key = "rg1"
  }
}
# give vm's managed identity access to read keyvault secrets/certs
keyvault_access_policies = {
  kv1 = {
    vm_msi_ro = {
      managed_identity_key    = "vm_msi"
      certificate_permissions = ["Get", "List"]
      secret_permissions      = ["Get", "List"]
    }
  }
}

