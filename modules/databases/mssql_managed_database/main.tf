terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }
  required_version = ">= 0.13"
}

locals {
  module_tag = {
    "module" = basename(abspath(path.module))
  }
  tags         = merge(local.module_tag, try(var.settings.tags, null), var.base_tags)
  arm_filename = "${path.module}/arm_managed_db.json"

  # this is the format required by ARM templates
  parameters_body = {
    serverName = {
      value = var.server_name
    }
    dbName = {
      value = azurecaf_name.manageddb.result
    }
    location = {
      value = var.location
    }
    collation = {
      value = try(var.settings.collation, "SQL_Latin1_General_CP1_CI_AS")
    }
    createMode = {
      value = try(var.settings.createMode, "Default")
    }
    sourceDatabaseId = {
      value = var.sourceDatabaseId
    }
    restorePointInTime = {
      value = try(var.settings.createMode, null) == "PointInTimeRestore" ? var.settings.restorePointInTime : ""
    }
    retentionDays = {
      value = try(var.settings.retentionDays, 7)
    }
    tags = {
      value = local.tags
    }
  }
}