module "caf" {
  source = "../../../../../caf"
  global_settings    = var.global_settings
  tags               = var.tags
  resource_groups    = var.resource_groups
  event_hub_namespaces  = var.event_hub_namespaces  
}
  
