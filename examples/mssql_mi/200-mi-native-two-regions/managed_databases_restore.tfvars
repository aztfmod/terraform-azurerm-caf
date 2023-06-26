#database restored from backup
mssql_managed_databases_restore = {
  # managed_db4 = {
  #   #Database created with PIT backup of source db LTR using key settings defined below.
  #   version       = "v1" #version 1 uses azapi since it supports creation from backup.
  #   name          = "lz-sql-managed-db4"
  #   tags          = { "category" = "sensitive" }
  #   mi_server_key = "sqlmi1"

  #   properties = {
  #     auto_complete_restore = true
  #     catalog_collation     = "DATABASE_DEFAULT" #"Default"
  #     collation             = "SQL_Latin1_General_CP1_CI_AS"
  #     create_mode           = "PointInTimeRestore" #"Default","PointInTimeRestore","Recovery","RestoreExternalBackup","RestoreLongTermRetentionBackup"
  #     source_database = {
  #       database_key = "managed_db2"
  #     }
  #     restore_point_datetime = "2023-04-12T10:01:47.000Z"
  #   }

  #   long_term_retention_policy = {
  #     weekly_retention  = "P6W"
  #     monthly_retention = "P4M"
  #     yearly_retention  = "P1Y"
  #     week_of_year      = 1
  #   }
  #   short_term_retention_days = 10
  # }
  # managed_db5 = {
  #   #Database created with long term retention backup with id with LTR settings
  #   version       = "v1" #version 1 managed uses azapi since it supports creation from backup.
  #   name          = "lz-sql-managed-db5"
  #   tags          = { "category" = "sensitive" }
  #   mi_server_key = "sqlmi1"

  #   properties = {
  #     auto_complete_restore         = true
  #     catalog_collation             = "DATABASE_DEFAULT" #"Default"
  #     collation                     = "SQL_Latin1_General_CP1_CI_AS"
  #     create_mode                   = "RestoreLongTermRetentionBackup" #"Default","PointInTimeRestore","Recovery","RestoreExternalBackup","RestoreLongTermRetentionBackup"
  #     long_term_retention_backup_id = "/subscriptions/00000000-4fb1-49f3-9664-4d00755cbe94/resourceGroups/ztjs-rg-sqlmi-db-re1/providers/Microsoft.Sql/locations/australiaeast/longTermRetentionManagedInstances/ztjs-sqlmi-sqlmi1/longTermRetentionDatabases/ztjs-sqldb-lz-sql-managed-db2/longTermRetentionManagedInstanceBackups/a5225abd-8f48-44ee-a904-2eb4db42adee;133256642630000000"
  #   }
  #   short_term_retention_days = 6
  #   long_term_retention_policy = {
  #     weekly_retention  = "P1W"
  #     monthly_retention = "P2M"
  #     yearly_retention  = "P3Y"
  #     week_of_year      = 4
  #   }
  #   short_term_retention_days = 5
  # }
  # managed_db6 = {
  #   #Database created using point in time restore from a dropped database
  #   version       = "v1" #version 1 managed uses azapi since it supports creation from backup.
  #   name          = "lz-sql-managed-db6"
  #   tags          = { "category" = "sensitive" }
  #   mi_server_key = "sqlmi1"

  #   properties = {
  #     auto_complete_restore = true
  #     catalog_collation     = "DATABASE_DEFAULT" #"Default"
  #     collation             = "SQL_Latin1_General_CP1_CI_AS"
  #     create_mode           = "PointInTimeRestore" #"Default","PointInTimeRestore","Recovery","RestoreExternalBackup","RestoreLongTermRetentionBackup"
  #     source_database = {
  #       id = "/subscriptions/00000000-4fb1-49f3-9664-4d00755cbe94/resourceGroups/wesl-rg-sqlmi-db-re1/providers/Microsoft.Sql/managedInstances/wesl-sqlmi-sqlmi1/databases/wesl-sqldb-lz-sql-managed-db1"

  #     }
  #     #is_source_database_deleted = false
  #     restore_point_datetime = "2023-04-18T06:16:26.000Z"

  #   }
  #   short_term_retention_days = 6
  #   long_term_retention_policy = {
  #     weekly_retention  = "P6W"
  #     monthly_retention = "P4M"
  #     yearly_retention  = "P1Y"
  #     week_of_year      = 12
  #   }
  #   short_term_retention_days = 10
  # }

  # managed_db7 = {
  #   #Database created using point in time restore from a dropped database
  #   version       = "v1" #version 1 managed uses azapi since it supports creation from backup.
  #   name          = "lz-sql-managed-db7"
  #   tags          = { "category" = "sensitive" }
  #   mi_server_key = "sqlmi1"

  #   properties = {
  #     auto_complete_restore = true
  #     catalog_collation     = "DATABASE_DEFAULT" #"Default"
  #     collation             = "SQL_Latin1_General_CP1_CI_AS"
  #     create_mode           = "PointInTimeRestore" #"Default","PointInTimeRestore","Recovery","RestoreExternalBackup","RestoreLongTermRetentionBackup"
  #     source_database = {
  #       id = "/subscriptions/0000000-4fb1-49f3-9664-4d00755cbe94/resourceGroups/ztjs-rg-sqlmi-db-re1/providers/Microsoft.Sql/managedInstances/ztjs-sqlmi-sqlmi1/restorableDroppedDatabases/ztjs-sqldb-lz-sql-managed-db3,133257696239830000"

  #     }
  #     is_source_database_deleted = true
  #     restore_point_datetime     = "2023-04-12T10:40:00.000Z"

  #   }
  #   short_term_retention_days = 6
  #   long_term_retention_policy = {
  #     weekly_retention  = "P6W"
  #     monthly_retention = "P4M"
  #     yearly_retention  = "P1Y"
  #     week_of_year      = 1
  #   }
  #   short_term_retention_days = 10
  # }
  # managed_db8 = {
  #   #Database created with PIT backup of source db LTR using key settings defined below.
  #   version       = "v1" #version 1 uses azapi since it supports creation from backup.
  #   name          = "lz-sql-managed-db8"
  #   tags          = { "category" = "sensitive" }
  #   mi_server_key = "sqlmi1"

  #   properties = {
  #     auto_complete_restore = true
  #     catalog_collation     = "DATABASE_DEFAULT" #"Default"
  #     collation             = "SQL_Latin1_General_CP1_CI_AS"
  #     create_mode           = "PointInTimeRestore" #"Default","PointInTimeRestore","Recovery","RestoreExternalBackup","RestoreLongTermRetentionBackup"
  #     source_database = {
  #       database_key = "managed_db2"
  #     }
  #     restore_point_datetime = "2023-04-12T10:01:47.000Z"
  #   }

  #   long_term_retention_policy = {
  #     weekly_retention  = "P6W"
  #     monthly_retention = "P4M"
  #     yearly_retention  = "P1Y"
  #     week_of_year      = 1
  #   }
  #   short_term_retention_days = 10


}

