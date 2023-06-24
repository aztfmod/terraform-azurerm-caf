
locals {
  library_path = local.azuread.azuread_conditional_access.library_path
  template_file_variables = local.azuread.azuread_conditional_access.template_file_variables

  conditional_access_policies_json = tolist(fileset(local.library_path, "**/*.{json,json.tftpl}"))
  conditional_access_policies_yaml = tolist(fileset(local.library_path, "**/*.{yml,yml.tftpl,yaml,yaml.tftpl}"))
}
# Create datasets containing conditional access policies from each source and file type
locals {
  conditional_access_policies_dataset_from_json = {
  for filepath in local.conditional_access_policies_json :
  filepath => jsondecode(templatefile("${local.library_path}/${filepath}", local.template_file_vars))
  }
  conditional_access_policies_from_yaml = {
  for filepath in local.conditional_access_policies_yaml :
  filepath => yamldecode(templatefile("${local.library_path}/${filepath}", local.template_file_vars))
  }
}

# Convert the containing conditional datasets into maps
locals {
  conditional_access_policies_map_from_json = {
  for key, value in local.conditional_access_policies_dataset_from_json :
  keys(value)[0] => values(value)[0]
  }
  conditional_access_policies_map_from_yaml = {
  for key, value in local.conditional_access_policies_from_yaml :
  keys(value)[0] => values(value)[0]
  }
}

# Merge the maps into a single map, and extract the desired conditional access policies.
locals {
  conditional_access_policies = merge(
    local.conditional_access_policies_map_from_json,
    local.conditional_access_policies_map_from_yaml
  )
}

# The following locals are used in template functions to provide values
locals {
  core_template_file_variables = {}
  template_file_vars = merge(
    local.template_file_variables,
    local.core_template_file_variables,
  )
}

module "conditional_access" {
  source   = "./modules/azuread/conditional_access"
  for_each = local.conditional_access_policies

  name             = each.key
  state            = each.value.state
  conditions       = each.value.conditions
  grant_controls   = each.value.grant_controls
  session_controls = lookup(each.value, "session_controls", null)

  client_config     = local.client_config
  global_settings   = local.global_settings
#  resources = {
#    azuread_applications = local.combined_objects_azuread_applications
#    azuread_groups       = local.combined_objects_azuread_groups
#    azuread_users        = local.combined_objects_azuread_users
#  }
}

output "conditional_access" {
  value = module.conditional_access
}
