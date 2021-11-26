data "azurerm_key_vault_secret" "packer_client_id" {
  name         = format("%s-client-id", var.settings.secret_prefix)
  key_vault_id = var.key_vault_id
}

data "azurerm_key_vault_secret" "packer_secret" {
  name         = format("%s-client-secret", var.settings.secret_prefix)
  key_vault_id = var.key_vault_id
}

resource "local_file" "packer_template" {
  content = templatefile(var.settings.packer_template_filepath,
    {
      client_id                         = data.azurerm_key_vault_secret.packer_client_id.value
      client_secret                     = data.azurerm_key_vault_secret.packer_secret.value
      tenant_id                         = var.tenant_id
      subscription_id                   = var.subscription
      os_type                           = var.settings.os_type
      image_publisher                   = var.settings.image_publisher
      image_offer                       = var.settings.image_offer
      image_sku                         = var.settings.image_sku
      location                          = var.location
      vm_size                           = var.settings.vm_size
      managed_image_resource_group_name = var.resource_group_name

      managed_image_name    = var.settings.managed_image_name
      ansible_playbook_path = var.settings.ansible_playbook_path

      //shared_image_gallery destination values. If publishing to a different Subscription, change the following arguments and supply the values as variables
      subscription        = var.subscription
      resource_group      = var.resource_group_name
      gallery_name        = var.gallery_name
      image_name          = var.image_name
      image_version       = var.settings.shared_image_gallery_destination.image_version
      replication_regions = var.settings.shared_image_gallery_destination.replication_regions
    }
  )
  filename             = var.settings.packer_template_filepath
  file_permission      = "0640"
  directory_permission = "0755"
}

resource "null_resource" "create_image" {
  provisioner "local-exec" {
    command = "packer build ${var.settings.packer_template_filepath}"
  }
  depends_on = [
    local_file.packer_template
  ]
}

data "azurerm_shared_image_version" "image_version" {
  name                = var.settings.shared_image_gallery_destination.image_version
  gallery_name        = var.gallery_name
  image_name          = var.image_name
  resource_group_name = var.resource_group_name
  depends_on = [
    null_resource.create_image
  ]
}

resource "time_sleep" "time_delay_3" {
  destroy_duration = "60s"
}

resource "null_resource" "delete_image" {
  triggers = {
    resource_id = data.azurerm_shared_image_version.image_version.id
  }
  provisioner "local-exec" {
    when        = destroy
    interpreter = ["/bin/bash"]
    command     = format("%s/destroy_image.sh", path.module)
    on_failure  = fail
    environment = {
      RESOURCE_IDS = self.triggers.resource_id
    }
  }
  depends_on = [
    time_sleep.time_delay_3
  ]

}
