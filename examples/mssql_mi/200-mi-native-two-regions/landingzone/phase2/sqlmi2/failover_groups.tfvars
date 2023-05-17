
mssql_mi_failover_groups = {
  sqlmi1_sqlmi2 = {
    version = "v1"
    name    = "sqlmi1-sqlmi2"
    region  = "region2"

    resource_group = {
      key = "sqlmi_region2"
    }
    primary_server = {
      lz_key        = "sqlmi1"
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
