resource "azapi_resource" "mssql_job_agents" {
  count = try(var.settings.job, null) == null ? 0 : 1

  type      = "Microsoft.Sql/servers/jobAgents@2024-05-01-preview"
  name      = var.settings.job.name
  location  = var.location
  parent_id = var.mssql_servers[try(var.settings.lz_key, var.client_config.landingzone_key)][var.settings.mssql_server_key].id
  tags      = local.tags

  identity {
    type = "UserAssigned"

    # if type contains UserAssigned, `identity_ids` is mandatory
    identity_ids = flatten([
      for managed_identity in var.settings.job.identity.managed_identities : [
        var.managed_identities[try(managed_identity.lz_key, var.client_config.landingzone_key)][managed_identity.key].id
      ]
    ])
  }

  body = jsonencode({
    properties = {
      databaseId = azurerm_mssql_database.mssqldb.id
    }
    sku = {
      name = var.settings.job.sku
    }
  })

  schema_validation_enabled = false
  # response_export_values    = ["properties.outputs"]
}

resource "azapi_resource" "mssql_job_agents_jobs" {
  for_each = try(var.settings.job.jobs, {})

  type      = "Microsoft.Sql/servers/jobAgents/jobs@2024-05-01-preview"
  name      = each.value.name
  parent_id = azapi_resource.mssql_job_agents.0.id
  body = jsonencode({
    properties = {
      description = try(each.value.description, null)
      schedule = {
        enabled   = try(each.value.schedule.enabled, false)
        startTime = try(each.value.schedule.startTime, "0001-01-01T00:00:00Z")
        endTime   = try(each.value.schedule.endTime, "0001-01-01T00:00:00Z")
        interval  = try(each.value.schedule.interval, null)
        type      = try(each.value.schedule.type, "Once")
      }
    }
  })

  schema_validation_enabled = false
  response_export_values    = ["properties.outputs"]
}

resource "azapi_resource" "mssql_job_agents_job_steps" {
  for_each = {
    for idx, item in flatten([
      for job_key, job in try(var.settings.job.jobs, {}) : [
        for step_key, step in try(job.steps, {}) : {
          job_key  = job_key
          step_key = step_key
          step     = step
        }
      ]
    ]) : "${item.job_key}-${item.step_key}" => item
  }

  type      = "Microsoft.Sql/servers/jobAgents/jobs/steps@2024-05-01-preview"
  name      = each.value.step.name
  parent_id = azapi_resource.mssql_job_agents_jobs[each.value.job_key].id

  body = jsonencode({
    properties = {
      action = {
        source = each.value.step.action.source
        type   = each.value.step.action.type
        value  = each.value.step.action.value
      }
      credential = try(each.value.step.credential, null)
      executionOptions = lookup(each.value.step, "executionOptions", null) != null ? {
        initialRetryIntervalSeconds    = try(each.value.step.executionOptions.initialRetryIntervalSeconds, null)
        maximumRetryIntervalSeconds    = try(each.value.step.executionOptions.maximumRetryIntervalSeconds, null)
        retryAttempts                  = try(each.value.step.executionOptions.retryAttempts, null)
        retryIntervalBackoffMultiplier = try(each.value.step.executionOptions.retryIntervalBackoffMultiplier, null)
        timeoutSeconds                 = try(each.value.step.executionOptions.timeoutSeconds, null)
      } : null
      stepId      = each.value.step.stepId
      targetGroup = azapi_resource.mssql_job_agents_targetgroups[keys(var.settings.job.jobs[each.value.job_key].targetgroups)[0]].id
    }
  })
  schema_validation_enabled = false
}

resource "azapi_resource" "mssql_job_agents_targetgroups" {
  for_each = {
    for item in flatten([
      for job_key, job_value in try(var.settings.job.jobs, {}) : [
        for tg_key, tg_value in try(job_value.targetgroups, {}) : {
          tg_key   = tg_key
          job_key  = job_key
          tg_value = tg_value
        }
      ]
    ]) : item.tg_key => item
  }

  type      = "Microsoft.Sql/servers/jobAgents/targetGroups@2024-05-01-preview"
  name      = each.value.tg_value.name
  parent_id = azapi_resource.mssql_job_agents.0.id

  body = jsonencode({
    properties = {
      members = [
        {
          databaseName   = azurerm_mssql_database.mssqldb.name
          serverName     = var.mssql_servers[try(var.settings.lz_key, var.client_config.landingzone_key)][var.settings.mssql_server_key].name
          membershipType = each.value.tg_value.members.membershipType
          type           = "SqlDatabase"
        }
      ]
    }
  })

  schema_validation_enabled = false
  response_export_values    = ["properties.outputs"]
}

resource "azapi_resource" "mssql_job_agents_private_endpoint" {
  count = try(var.settings.job.private_endpoint_name, null) == null ? 0 : 1

  type      = "Microsoft.Sql/servers/jobAgents/privateEndpoints@2024-05-01-preview"
  name      = var.job_private_endpoint_name
  parent_id = azapi_resource.mssql_job_agents.0.id

  body = jsonencode({
    properties = {
      targetServerAzureResourceId = var.mssql_servers[try(var.settings.lz_key, var.client_config.landingzone_key)][var.settings.mssql_server_key].id
    }
  })
  schema_validation_enabled = false
  response_export_values    = ["properties.privateEndpointConnections"]
  depends_on                = [azapi_resource.mssql_job_agents]
}

resource "time_sleep" "wait_for_private_endpoint" {
  count = try(var.settings.job.private_endpoint_name, null) == null ? 0 : 1

  create_duration = "2m"
  depends_on      = [azapi_resource.mssql_job_agents]

  triggers = {
    timestamp = timestamp()
  }
}
locals {
  connections = jsondecode(data.azapi_resource.sql_server.output).properties.privateEndpointConnections

  private_endpoint_connection_name = (
    local.connections == null || length(local.connections) == 0 ? null :
    try(
      element([
        for connection in local.connections :
        connection.id
        if var.job_private_endpoint_name != null && connection.properties.privateLinkServiceConnectionState.status == "Pending"
      ], 0),
      "temp"
    )
  )
}

# Data source pour récupérer les informations sur le serveur SQL
data "azapi_resource" "sql_server" {

  type                   = "Microsoft.Sql/servers@2024-05-01-preview"
  resource_id            = var.mssql_servers[try(var.settings.lz_key, var.client_config.landingzone_key)][var.settings.mssql_server_key].id
  response_export_values = ["properties.privateEndpointConnections"]

  depends_on = [time_sleep.wait_for_private_endpoint]
}

resource "azapi_update_resource" "approve_private_endpoint" {
  count = try(var.settings.job.private_endpoint_name, null) == null ? 0 : 1

  type = "Microsoft.Sql/servers/privateEndpointConnections@2024-05-01-preview"
  # resource_id = "${var.mssql_servers[try(var.settings.lz_key, var.client_config.landingzone_key)][var.settings.mssql_server_key].id}/privateEndpointConnections/${local.private_endpoint_connection_name}"
  resource_id = local.private_endpoint_connection_name
  body = jsonencode({
    properties = {
      privateLinkServiceConnectionState = {
        status      = "Approved"
        description = "Approved by Terraform"
      }
    }
  })

  lifecycle {
    ignore_changes = all
  }
}
