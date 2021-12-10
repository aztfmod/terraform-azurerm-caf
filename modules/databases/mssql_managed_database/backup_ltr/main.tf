terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }

}

locals {
  module_tag = {
    "module" = basename(abspath(path.module))
  }
  arm_filename = "${path.module}/arm_backup_ltr.json"

  # this is the format required by ARM templates
  parameters_body = {
    serverName = {
      value = var.server_name
    }
    dbName = {
      value = var.db_name
    }
    weeklyRetention = {
      value = try(var.settings.weeklyRetention, "")
    }
    monthlyRetention = {
      value = try(var.settings.monthlyRetention, "")
    }
    yearlyRetention = {
      value = try(var.settings.yearlyRetention, "")
    }
    weekOfYear = {
      value = try(var.settings.weekOfYear, 0)
    }
  }
}