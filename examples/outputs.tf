output virtual_machines {
  value = module.caf.virtual_machines
}

output mssql_managed_instances {
  value     = module.caf.mssql_managed_instances
  sensitive = false
}

output dns_zones {
  value       = module.caf.dns_zones
}
