

mssql_managed_instances_secondary = {
  sqlmi2 = {
    version = "v1"
    region  = "region2"
    resource_group = {
      key = "sqlmi_region2"
    }
    name                = "srv2"
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
      # azuread_group_id   = "<specify existing azuread group's Object Id (OID) here>"

    }
    keyvault = {
      key = "sqlmi_rg1"
    }
    license_type        = "BasePrice" #BasePrice (Hybrid Benefit) or LicenseIncluded (Pay-As-You-Go)
    minimal_tls_version = "1.2"
    //networking
    networking = {
      vnet_key   = "sqlmi_region2"
      subnet_key = "sqlmi2"
    }
    proxy_override                 = "Default" #"Default,Proxy,Redirect"
    maintenance_configuration_name = "SQL_Default"
    #service_principal
    identity = {
      type                  = "UserAssigned"
      managed_identity_keys = ["mi2"]
    }

    primary_server = {
      mi_server_key = "sqlmi1"
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


mssql_mi_failover_groups = {
  sqlmi1_sqlmi2 = {
    version            = "v1"
    resource_group_key = "sqlmi_region1"
    name               = "sqlmi1-sqlmi2"
    primary_server = {
      mi_server_key = "sqlmi1"
    }
    secondary_server = {
      mi_server_key = "sqlmi2"
    }
    readonly_endpoint_failover_policy_enabled = false
    read_write_endpoint_failover_policy = {
      mode          = "Automatic"
      grace_minutes = 60
    }
  }
}
