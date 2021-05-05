
module "load_resource_groups" {
  source   = "./modules/load_resource_group"
  depends_on = [ module.resource_groups ]
  for_each = try(var.load_resource_groups, {})

  settings            = each.value
}

output "load_resource_groups" {
  value = module.load_resource_groups

}
