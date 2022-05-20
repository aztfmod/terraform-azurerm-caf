locals {
  type             = var.settings.connection.type
  port             = try(var.settings.connection.port, null)
  user             = var.settings.connection.user
  private_key      = try(file(var.settings.connection.private_key_file), try(data.azurerm_key_vault_secret.vm_private_key[0].value, null)) #load from file or AKV
  password         = try(var.settings.connection.password, try(data.azurerm_key_vault_secret.vm_password[0].value, null))
  timeout          = try(var.settings.connection.timeout, 30)
  runbook_path     = var.settings.runbook_path
  private_key_file = format("%s/pk.key", path.cwd)
  public_key_file  = format("%s/pk.pub", path.cwd)
  host_literals    = try(var.settings.connection.endpoint.host, null)
  host_private_ip  = try(var.settings.connection.endpoint.private_ip_address, null) != null ? coalesce(var.virtual_machines[var.client_config.landingzone_key][var.settings.connection.endpoint.private_ip_address.vm_key].nics[var.settings.connection.endpoint.private_ip_address.nic_key].private_ip_address, var.virtual_machines[var.settings.connection.endpoint.lz_key][var.settings.connection.endpoint.private_ip_address.vm_key].nics[var.settings.connection.endpoint.private_ip_address.nic_key].private_ip_address) : null
  host_public_ip   = try(var.settings.connection.endpoint.public_ip_address_key, null) != null ? coalesce(try(var.public_ip_addresses[var.client_config.landingzone_key][var.settings.connection.endpoint.public_ip_address_key].fqdn, var.public_ip_addresses[var.settings.connection.endpoint.lz_key][var.settings.connection.endpoint.public_ip_address_key].fqdn), try(var.public_ip_addresses[var.client_config.landingzone_key][var.settings.connection.endpoint.public_ip_address_key].ip_address, var.public_ip_addresses[var.settings.connection.endpoint.lz_key][var.settings.connection.endpoint.public_ip_address_key].ip_address)) : null
  host             = coalesce(local.host_literals, local.host_private_ip, local.host_public_ip)
}


resource "null_resource" "ansible_playbook_linux" {
  depends_on = [local_sensitive_file.private_key, local_file.public_key]
  count      = lower(var.settings.connection.type) == "ssh" ? 1 : 0

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ${local.user} -i '${local.host},' --private-key ${local.private_key_file} -e 'pub_key=${local.public_key_file}' ${fileexists(local.runbook_path) ? local.runbook_path : format("%s/%s", path.cwd, local.runbook_path)}"
  }

  provisioner "local-exec" {
    command = "rm -f ${local.private_key_file}"
  }
  provisioner "local-exec" {
    command = "rm -f ${local.public_key_file}"
  }
}


## retrieve AKV secrets from VM object for OpenSSH

data "azurerm_key_vault_secret" "vm_private_key" {
  count        = try(var.settings.connection.private_key_from_vm, null) != null ? 1 : 0
  name         = try(var.virtual_machines[var.client_config.landingzone_key][var.settings.connection.private_key_from_vm.vm_key].ssh_keys.ssh_private_key_pem, var.virtual_machines[var.settings.connection.private_key_from_vm.lz_key][var.settings.connection.private_key_from_vm.vm_key].ssh_keys.ssh_private_key_pem)
  key_vault_id = try(var.virtual_machines[var.client_config.landingzone_key][var.settings.connection.private_key_from_vm.vm_key].ssh_keys.keyvault_id, var.virtual_machines[var.settings.connection.private_key_from_vm.lz_key][var.settings.connection.private_key_from_vm.vm_key].ssh_keys.keyvault_id)
}

data "azurerm_key_vault_secret" "vm_public_key" {
  count        = try(var.settings.connection.public_key_from_vm, null) != null ? 1 : 0
  name         = try(var.virtual_machines[var.client_config.landingzone_key][var.settings.connection.public_key_from_vm.vm_key].ssh_keys.ssh_private_key_open_ssh, var.virtual_machines[var.settings.connection.public_key_from_vm.lz_key][var.settings.connection.public_key_from_vm.vm_key].ssh_keys.ssh_private_key_open_ssh)
  key_vault_id = try(var.virtual_machines[var.client_config.landingzone_key][var.settings.connection.public_key_from_vm.vm_key].ssh_keys.keyvault_id, var.virtual_machines[var.settings.connection.public_key_from_vm.lz_key][var.settings.connection.public_key_from_vm.vm_key].ssh_keys.keyvault_id)
}

resource "local_sensitive_file" "private_key" {
  count           = try(var.settings.connection.private_key_from_vm, null) != null ? 1 : 0
  content         = data.azurerm_key_vault_secret.vm_private_key[0].value
  file_permission = "0600"
  filename        = format("%s/pk.key", path.cwd)
}

resource "local_file" "public_key" {
  count    = try(var.settings.connection.private_key_from_vm, null) != null ? 1 : 0
  content  = data.azurerm_key_vault_secret.vm_public_key[0].value
  filename = format("%s/pk.pub", path.cwd)
}


data "azurerm_key_vault_secret" "vm_password" {
  count        = try(var.settings.connection.password_from_vm, null) != null ? 1 : 0
  name         = try(var.virtual_machines[var.client_config.landingzone_key][var.settings.connection.password_from_vm.vm_key].admin_password_keys.password_name, var.virtual_machines[var.settings.connection.password_from_vm.lz_key][var.settings.connection.password_from_vm.vm_key].admin_password_keys.password_name)
  key_vault_id = try(var.virtual_machines[var.client_config.landingzone_key][var.settings.connection.password_from_vm.vm_key].admin_password_keys.keyvault_id, var.virtual_machines[var.settings.connection.password_from_vm.lz_key][var.settings.connection.password_from_vm.vm_key].admin_password_keys.keyvault_id)
}
