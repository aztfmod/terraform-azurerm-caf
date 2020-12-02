
data "template_file" "packer_template_generator" {
  template = file(var.settings.packer_template_filepath)
  vars = {
    os_type                           = var.settings.os_type
    image_publisher                   = var.settings.image_publisher
    image_offer                       = var.settings.image_offer
    image_sku                         = var.settings.image_sku
    location                          = var.location
    vm_size                           = var.settings.vm_size
    managed_image_resource_group_name = var.resource_group_name
    managed_image_name                = var.settings.managed_image_name
    ansible_playbook_path             = var.settings.ansible_playbook_path

    //shared_image_gallery destination values. If publishing to a different Subscription, change the following arguments and supply the values as variables
    subscription        = var.subscription
    resource_group      = var.resource_group_name
    gallery_name        = var.gallery_name
    image_name          = var.image_name
    image_version       = var.settings.shared_image_gallery_destination.image_version
    replication_regions = var.settings.shared_image_gallery_destination.replication_regions
  }
}

resource "null_resource" "packer_configuration_generator" {
  provisioner "local-exec" {
    command = "cat > ${var.settings.packer_config_filepath} <<EOL\n${data.template_file.packer_template_generator.rendered}\nEOL"
  }
  depends_on = [
    data.template_file.packer_template_generator
  ]
}

data "azurerm_key_vault_secret" "private_ssh_key" {
  name         = var.ssh_private_pem_key_name
  key_vault_id = var.key_vault_id
}

resource "null_resource" "generate_private_key" {
  provisioner "local-exec" {
    command = "echo '${data.azurerm_key_vault_secret.private_ssh_key.value}'  > /tmp/key ; sudo chmod 600 /tmp/key"
  }
  depends_on = [
    data.azurerm_key_vault_secret.private_ssh_key
  ]
}

resource "null_resource" "copy_files" {
  provisioner "file" {
    source      = "./shared_image_gallery/packer_managed_identity/packer_files/"
    destination = "/tmp/packer"
  }
  connection {
    type        = var.settings.type
    user        = var.settings.admin_username
    private_key = "/tmp/key"
    host        = try(var.public_ip_addresses[var.client_config.landingzone_key][var.settings.public_ip_address_key].ip_address, var.public_ip_addresses[var.settings.lz_key][var.settings.public_ip_address_key].ip_address)
    port        = var.settings.port
    timeout     = var.settings.timeout
  }
  depends_on = [
    null_resource.generate_private_key,
    null_resource.packer_configuration_generator
  ]
}

resource "time_sleep" "time_delay_1" {
  create_duration = "60s"
  depends_on = [
    null_resource.copy_files
  ]
}

resource "null_resource" "execute_packer" {
  provisioner "remote-exec" {
    inline = [
      "packer build ${var.settings.packer_configuration_remote_filepath}"
    ]
  }
  connection {
    type        = var.settings.type
    user        = var.settings.admin_username
    private_key = "/tmp/private-key"
    host        = try(var.public_ip_addresses[var.client_config.landingzone_key][var.settings.public_ip_address_key].ip_address, var.public_ip_addresses[var.settings.lz_key][var.settings.public_ip_address_key].ip_address)
    port        = var.settings.port
    timeout     = var.settings.timeout
  }
  depends_on = [
    null_resource.packer_configuration_generator,
    null_resource.copy_files,
    time_sleep.time_delay_1
  ]
}

# imports Image ID, to help in rolling back, as its being created by Packer (outside of Terraform)
data "azurerm_shared_image_version" "image_version" {
  name                = var.settings.shared_image_gallery_destination.image_version
  gallery_name        = var.gallery_name
  image_name          = var.image_name
  resource_group_name = var.resource_group_name
  depends_on = [
    null_resource.execute_packer
  ]
}

resource "null_resource" "delete_image" {
  triggers = {
    resource_id = data.azurerm_shared_image_version.image_version.id
  }
  provisioner "local-exec" {
    when        = destroy
    interpreter = ["/bin/sh"]
    command     = format("%s/shared_image_gallery/packer_managed_identity/destroy_image.sh", ".")
    on_failure  = fail
    environment = {
      RESOURCE_IDS = self.triggers.resource_id
    }
  }
}