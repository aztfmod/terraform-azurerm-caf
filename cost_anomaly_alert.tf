module "cost_anomaly_alert" {
  source   = "./modules/cost_management/cost_anomaly_alert"
  for_each = local.shared_services.cost_anomaly_alert
  settings = each.value
}