
mssql_mi_failover_groups = {
  sqlmi1_sqlmi2 = {
    version = "v1"
    name    = "sqlmi1-sqlmi2"

    primary_server = {
      lz_key        = "sqlmi1"
      mi_server_key = "sqlmi1"
    }
    secondary_server = {
      lz_key        = "sqlmi2"
      mi_server_key = "sqlmi2"
    }
    secondary_type = "Standby" # or Geo
    read_write_endpoint_failover_policy = {
      mode          = "Automatic"
      grace_minutes = 60
    }
  }
}
