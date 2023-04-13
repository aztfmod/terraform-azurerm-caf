#database restored from backup
mssql_managed_databases_restore = {
  managed_db4 = {
    #Database created with PIT backup of source db LTR using key settings defined below.
    version       = "v1" #version 1 uses azapi since it supports creation from backup.
    name          = "lz-sql-managed-db4"
    tags          = { "category" = "sensitive" }
    mi_server_key = "sqlmi1"

    properties = {
      auto_complete_restore = true
      catalog_collation     = "DATABASE_DEFAULT" #"Default"
      collation             = "SQL_Latin1_General_CP1_CI_AS"
      create_mode           = "PointInTimeRestore" #"Default","PointInTimeRestore","Recovery","RestoreExternalBackup","RestoreLongTermRetentionBackup"
      source_database = {
        database_key = "managed_db2"
      }
      restore_point_datetime = "2023-04-12T10:01:47.000Z"
    }

    long_term_retention_policy = {
      weekly_retention  = "P6W"
      monthly_retention = "P4M"
      yearly_retention  = "P1Y"
      week_of_year      = 1
    }
    short_term_retention_days = 10
  }
  # managed_db5 = {
  #   #Database created with long term retention backup with id without LTR settings
  #   version       = "v1" #version 1 managed uses azapi since it supports creation from backup.
  #   name          = "lz-sql-managed-db5"
  #   tags          = { "category" = "sensitive" }
  #   mi_server_key = "sqlmi1"

  #   properties = {
  #     auto_complete_restore         = true
  #     catalog_collation             = "DATABASE_DEFAULT" #"Default"
  #     collation                     = "SQL_Latin1_General_CP1_CI_AS"
  #     create_mode                   = "RestoreLongTermRetentionBackup" #"Default","PointInTimeRestore","Recovery","RestoreExternalBackup","RestoreLongTermRetentionBackup"
  #     long_term_retention_backup_id = "/subscriptions/00000/resourceGroups/ztjs-rg-sqlmi-db-re1/providers/Microsoft.Sql/locations/australiaeast/longTermRetentionManagedInstances/ztjs-sqlmi-sqlmi1/longTermRetentionDatabases/ztjs-sqldb-lz-sql-managed-db1/longTermRetentionManagedInstanceBackups/150a93ee-e715-4bf1-ad04-ce397d6bc9be;133256642660000000"

  #   }
  #   short_term_retention_days = 6
  # }

}