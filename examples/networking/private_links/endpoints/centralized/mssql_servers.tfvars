mssql_servers = {
  sales_rg1 = {
    name                          = "sales-rg1"
    region                        = "region1"
    resource_group_key            = "rg1"
    version                       = "12.0"
    administrator_login           = "sqlsalesadmin"
    keyvault_key                  = "kv_rg1"
    connection_policy             = "Default"
    system_msi                    = true
    public_network_access_enabled = false

  }

}