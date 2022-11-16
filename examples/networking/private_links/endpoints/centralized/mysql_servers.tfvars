mysql_servers = {
  sales-re1 = {
    name                = "sales-re1"
    region              = "region1"
    resource_group_key  = "rg1"
    version             = "5.7"
    sku_name            = "GP_Gen5_2"
    storage_mb          = 5120
    administrator_login = "mysqlsalesadmin"
    #   Below password argument is used to set the DB password. If not passed, there will be a random password generated and stored in azure keyvault.
    #   administrator_login_password  = "ComplxP@ssw0rd!"
    keyvault_key                  = "kv_rg1"
    system_msi                    = true
    public_network_access_enabled = true
    auto_grow_enabled             = true
    vnet_key                      = "vnet_01"
    subnet_key                    = "subnet_01"


    extended_auditing_policy = {
      storage_account = {
        key = "level0"
      }
      retention_in_days = 7
    }


    mysql_configurations = {
      mysql_configuration = {
        name  = "interactive_timeout"
        value = "600"
      }
    }


    mysql_databases = {
      mysql_database = {
        name      = "mysql_server_sampledb"
        charset   = "UTF8"
        collation = "utf8_unicode_ci"
      }
    }


    tags = {
      segment = "sales"
    }

  }

}