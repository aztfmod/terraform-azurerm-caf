packer_service_principal = {
  build1 = {
    packer_template_filepath = "./shared_image_gallery/101-packer_service_principal/packer_files/packer_template_service_principal.json"
    packer_config_filepath   = "./shared_image_gallery/101-packer_service_principal/packer_files/packer_template_sp.json"
    secret_prefix            = "packer-client"
    keyvault_key             = "packer_client"
    managed_image_name       = "myImage"
    resource_group_key       = "sig" #for managed_image_resource_group_name
    os_type                  = "Linux"
    image_publisher          = "Canonical"
    image_offer              = "UbuntuServer"
    image_sku                = "16.04-LTS"
    location                 = "australiaeast"
    vm_size                  = "Standard_A2_v2"
    ansible_playbook_path    = "./shared_image_gallery/101-packer_service_principal/packer_files/ansible-ping.yml"
    shared_image_gallery_destination = {
      gallery_key         = "gallery1"
      image_key           = "image1"
      image_version       = "1.0.0"
      resource_group_key  = "sig"
      replication_regions = "australiaeast"
    }
  }
}
