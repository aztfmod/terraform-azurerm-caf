#database not restored from backup
mssql_managed_databases = {
  managed_db1 = {
    version                   = "v1"
    name                      = "lz-sql-managed-db1"
    mi_server_key             = "sqlmi1"
    short_term_retention_days = 30

    long_term_retention_policy = {
      weekly_retention  = "P12W"
      monthly_retention = "P12M"
      yearly_retention  = "P5Y"
      week_of_year      = 16
    }

  }
  managed_db2 = {
    version       = "v1"
    name          = "lz-sql-managed-db2"
    mi_server_key = "sqlmi1"
    long_term_retention_policy = {
      weekly_retention  = "P6W"
      monthly_retention = "P4M"
      yearly_retention  = "P1Y"
      week_of_year      = 2
    }
    short_term_retention_days = 7

  }
}
