output "vnet" {
  value = module.vnet_test.vnet
}

output "vnet_obj" {
  value = module.vnet_test.vnet_obj
}

output "subnet_ids_map" {
  value = module.vnet_test.subnet_ids_map
}

output "nsg_obj" {
  value = module.vnet_test.nsg_obj
}

output "vnet_subnets" {
  value = module.vnet_test.vnet_subnets
}

output "nsg_vnet" {
  value = module.vnet_test.nsg_vnet
}
