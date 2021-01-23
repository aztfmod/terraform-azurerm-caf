output virtual_machines {
  value = module.caf.virtual_machines
}

output mssql_managed_instances {
  value     = module.caf.mssql_managed_instances
  
}

output mssql_managed_instances_secondary {
  value     = module.caf.mssql_managed_instances_secondary
  sensitive = false
}
