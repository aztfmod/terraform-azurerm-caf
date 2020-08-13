
locals {
  convention = "cafrandom"
  name       = "caftest-aad"
  location   = "southeastasia"
  prefix     = ""
  max_length = ""
  postfix    = ""

  resource_groups = {
    test = {
      name     = "test-caf-aad"
      location = "southeastasia"
    },
  }

  tags = {
    environment = "DEV"
    owner       = "CAF"
  }

  keyvaults = {
    launchpad = {
      name                = "launchpad"
      resource_group_name = "caf-foundations"
      region              = "southeastasia"
      convention          = "cafrandom"
      sku_name            = "standard"
    }
  }

  aad_apps = {

    caf_launchpad = {
      convention              = "cafrandom"
      useprefix               = true
      application_name        = "caf_launchpad_level0"
      password_expire_in_days = 180
      keyvault = {
        keyvault_key  = "launchpad"
        secret_prefix = "caf-launchpad-level0"
        access_policies = {
          key_permissions    = []
          secret_permissions = ["Get", "List", "Set", "Delete"]
        }
      }
    }

    # Changing that key requires changing the value of azure_devops.aad_app_key
    azure_devops = {
      convention              = "cafrandom"
      useprefix               = true
      ad_application_name     = "caf-level0-security-devops-pat-rotation-aad-app"
      password_expire_in_days = 60
      tenant_name             = "terraformdev.onmicrosoft.com"
      reply_urls              = ["https://localhost"]
      keyvault = {
        keyvault_key  = "launchpad"
        secret_prefix = "caf-launchpad-level0"
        access_policies = {
          key_permissions    = []
          secret_permissions = ["Get", "List", "Set", "Delete"]
        }
      }
    }

  }

  aad_api_permissions = {
    azure_devops = {
      azure_devops_service = {
        resource_app_id = "499b84ac-1321-427f-aa17-267ca6975798"
        resource_access = {
          delegate_access_to_azure_devops_services = {
            id   = "ee69721e-6c3a-468f-a9ec-302d16a4c599"
            type = "Scope"
          }
        }
      }
    }

    caf_launchpad = {
      active_directory_graph = {
        resource_app_id = "00000002-0000-0000-c000-000000000000"
        resource_access = {
          active_directory_graph_resource_access_id_Application_ReadWrite_OwnedBy = {
            id   = "824c81eb-e3f8-4ee6-8f6d-de7f50d565b7"
            type = "Role"
          }
          active_directory_graph_resource_access_id_Directory_ReadWrite_All = {
            id   = "78c8a3c8-a07e-4b9e-af1b-b5ccab50a175"
            type = "Role"
          }
        }
      }

      microsoft_graph = {
        resource_app_id = "00000003-0000-0000-c000-000000000000"
        resource_access = {
          microsoft_graph_AppRoleAssignment_ReadWrite_All = {
            id   = "06b708a9-e830-4db3-a914-8e69da51d44f"
            type = "Role"
          }
          microsoft_graph_DelegatedPermissionGrant_ReadWrite_All = {
            id   = "8e8e4742-1d95-4f68-9d56-6ee75648c72a"
            type = "Role"
          }
          microsoft_graph_GroupReadWriteAll = {
            id   = "62a82d76-70ea-41e2-9197-370581804d09"
            type = "Role"
          }
          microsoft_graph_RoleManagement_ReadWrite_Directory = {
            id   = "9e3f62cf-ca93-4989-b6ce-bf83c28f9fe8"
            type = "Role"
          }
        }
      }
    }

  }

}
