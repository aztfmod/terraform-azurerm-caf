locals {
  arm_filename = "${path.module}/app_config_settings.json"

  # this is the format required by ARM templates
  parameters_body = {
    keyValueNames = {
      value = var.key_names
    }
    keyValueValues = {
      value = var.key_values
    }
    configName = {
      value = var.config_name
    }
    tags = {
      value = local.tags
    }
  }
}
