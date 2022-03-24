#
# Global settings
#
global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

#
# Resource groups to be created
#
resource_groups = {
  databricks_re1 = {
    name   = "databricks-re1"
    region = "region1"
  }
}

#
# Databricks workspace settings
#
databricks_workspaces = {
  sales_workspaces = {
    name               = "sales_workspace"
    resource_group_key = "databricks_re1"
    sku                = "standard"
    custom_parameters = {
      no_public_ip = false
    }
  }
}