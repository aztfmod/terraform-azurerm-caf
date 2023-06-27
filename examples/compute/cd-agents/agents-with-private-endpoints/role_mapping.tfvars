role_mapping = {
  built_in_role_mapping = {
    storage_containers = {
      scripts = {
        "Storage Blob Data Contributor" = {
          logged_in = {
            keys = ["user"]
          }
        }
        "Storage Blob Data Reader" = {
          managed_identities = {
            keys = ["gitops"]
          }
        }
      }
    }
    keyvaults = {
      agents = {
        "Key Vault Secrets Officer" = {
          logged_in = {
            keys = ["user"]
          }
          managed_identities = {
            keys = ["gitops"]
          }
        }
      }
    }
    virtual_machines = {
      azdo_level0 = {
        "Virtual Machine Administrator Login" = {
          logged_in = {
            keys = ["user"]
          }
        }
      }
      tfcloud = {
        "Virtual Machine Administrator Login" = {
          logged_in = {
            keys = ["user"]
          }
        }
      }
    }
  }
}
