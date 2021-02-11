output virtual_machines {
  value = module.caf.virtual_machines
}

output mssql_managed_instances {
  value = module.caf.mssql_managed_instances
}

output dns_zones {
  value = module.caf.dns_zones
}

output dns_zone_records {
  value = module.caf.dns_zone_records
}

output keyvault_certificates {
  value = module.caf.keyvault_certificates
}

output keyvault_certificate_requests {
  value = module.caf.keyvault_certificate_requests
}

output mssql_managed_instances_secondary {
  value     = module.caf.mssql_managed_instances_secondary
  sensitive = false
}

output storage_accounts {
  value     = module.caf.storage_accounts
  sensitive = false
}

output app_services {
  value     = module.caf.app_services
  sensitive = false
}
