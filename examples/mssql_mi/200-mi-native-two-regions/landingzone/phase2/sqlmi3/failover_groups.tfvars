
mssql_mi_failover_groups = {
  sqlmi1_sqlmi3 = {
    version = "v1"
    name    = "sqlmi1-sqlmi3"
    region  = "region3" # deployed with the primary server

    resource_group = {
      key = "sqlmi_region3"
    }
    primary_server = {
      lz_key        = "phase1"
      mi_server_key = "sqlmi1"
    }
    secondary_server = {
      mi_server_key = "sqlmi3"
    }
    readonly_endpoint_failover_policy_enabled = true
    read_write_endpoint_failover_policy = {
      mode          = "Automatic"
      grace_minutes = 60
    }
  }
}
