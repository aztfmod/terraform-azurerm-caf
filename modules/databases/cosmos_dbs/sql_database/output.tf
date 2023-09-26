output "id" {
  value = azurerm_cosmosdb_sql_database.database.id
}

output "name" {
  value = azurerm_cosmosdb_sql_database.database.name
}

output "sql_containers" {
  value = {
    for k, v in var.settings.containers : k => {
      "id" : azurerm_cosmosdb_sql_container.container[k].id
    }
  }
}
