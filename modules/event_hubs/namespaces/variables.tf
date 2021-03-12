variable global_settings {
  description = "Global settings object (see module README.md)"
}
variable settings {}
variable resource_group_name {}
variable location {}
variable base_tags {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map
}
variable client_config {
  description = "Client configuration object (see module README.md)."
}
variable storage_accounts {
  default = {}
}