module "caf" {
  source = "../../../../../../caf"
  global_settings    = var.global_settings
  tags               = var.tags
  resource_groups    = var.resource_groups
  webapp = {
    app_service_plans            = var.app_service_plans
    app_services                 = var.app_services
  }

}
  
