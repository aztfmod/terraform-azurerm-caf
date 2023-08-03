module "batch_jobs" {
  source   = "./modules/compute/batch/batch_job"
  for_each = local.compute.batch_jobs

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  batch_pool_id   = try(module.batch_pools[each.value.batch_pool_key].id, null)
}

output "batch_jobs" {
  value = module.batch_jobs
}
