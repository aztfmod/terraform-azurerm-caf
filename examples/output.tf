output diagnostics {
  value     = local.diagnostics
  sensitive = true
}

output mssql_servers {
  value     = module.caf.mssql_servers
  sensitive = false
}
