variable global_settings {
  description = "Global settings object (see module README.md)"
}
variable settings {}
variable server_id {}
variable storage_accounts {}
variable elastic_pool_id {
  default = null
}
variable base_tags {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map
}