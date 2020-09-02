output diagnostics {
  value     = local.diagnostics
  sensitive = true
}

output mssql_servers {
  value     = module.ase.mssql_servers
  sensitive = false
}
