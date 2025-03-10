output "id" {
  value = azurerm_mssql_database.mssqldb.id
}

output "name" {
  value = azurerm_mssql_database.mssqldb.name
}

output "server_id" {
  value = azurerm_mssql_database.mssqldb.server_id
}

output "server_name" {
  value = var.server_name
}

output "server_fqdn" {
  value = local.server_name
}

output "job_agent_id" {
  description = "ID of the MSSQL job agent"
  value = {
    for k, v in azapi_resource.mssql_job_agents : k => v.id
  }
}

