module "runbooks_ansible_playbooks" {
  depends_on = [module.virtual_machines, module.keyvaults, module.public_ip_addresses]
  source     = "./modules/compute/runbooks/ansible_playbook"
  for_each = {
    for key, value in try(var.compute.runbooks, {}) : key => value
    if try(value.type, "") == "ansible_playbook"
  }

  settings            = each.value
  keyvaults           = local.combined_objects_keyvaults
  public_ip_addresses = local.combined_objects_public_ip_addresses
  virtual_machines    = local.combined_objects_virtual_machines
  client_config       = local.client_config
}
