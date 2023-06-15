

mssql_managed_instances_secondary = {
  sqlmi3 = {
    version = "v1"

    name   = "srv3"
    region = "region3"

    resource_group = {
      key = "sqlmi_region3"
    }

    primary_server = {
      lz_key        = "sqlmi1"
      mi_server_key = "sqlmi1"
    }

    administrator_login = "adminuser"
    #administrator_login_password = "@dm1nu53r@30102020"
    ## if password not set, a random complex passwor will be created and stored in the keyvault
    ## the secret value can be changed after the deployment if needed
    ## When administrator_login_password use the following keyvault to store the password

    authentication_mode = "hybrid"
    # "aad_only", "hybrid"
    administrators = {
      # principal_type              = "Group"
      # sid                         = "000000-6c31-485e-a7d4-5b927171bd99"
      # login                       = "AAD DC Administrators"
      # tenant_id                    = "00000-ee35-4265-95f6-46e9a9b4ec96"

      # group key or existing group OID or upn supported (require authentication_mode = "aad_only")
      login_username    = "AAD DC Administrators"
      azuread_group_key = "sql_mi_admins"
      lz_key            = "sqlmi1"
      # azuread_group_id   = "<specify existing azuread group's Object Id (OID) here>"

    }
    keyvault = {
      lz_key = "sqlmi1"
      key    = "sqlmi_rg1"
    }
    license_type        = "BasePrice" #BasePrice (Hybrid Benefit) or LicenseIncluded (Pay-As-You-Go)
    minimal_tls_version = "1.2"
    //networking
    networking = {
      vnet_key   = "sqlmi_region3"
      subnet_key = "sqlmi3"
    }
    proxy_override                 = "Default" #"Default,Proxy,Redirect"
    maintenance_configuration_name = "SQL_Default"
    #service_principal
    identity = {
      type                  = "UserAssigned"
      managed_identity_keys = ["mi3"]
      # remote = {     # Use that block to reference a remote user MSI
      #   "sqlmi1" = { # value of the lz_key
      #     managed_identity_keys = [
      #       "mi2"
      #     ]
      #   }
      # }
    }

    public_data_endpoint_enabled = true

    sku = {
      name = "GP_Gen5"
    }
    backup_storage_redundancy = "LRS"
    storage_size_in_gb        = 32
    vcores                    = 4
    transparent_data_encryption = {
      enabled = true
    }
  }
}

