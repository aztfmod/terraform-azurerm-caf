variable global_settings {
  default = {}
}

variable resource_groups {
  default = null
}


variable tags {
  default = null
  type    = map
}

variable mssql_databases {
  default = {}
}

variable mssql_failover_groups {
  default = {}
}

variable mssql_servers {
  default = {}
}

variable var_folder_path {
  default = {}
}