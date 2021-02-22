packer_managed_identity = {
  build1 = {
    packer_template_filepath             = "./shared_image_gallery/100-packer_managed_identity/packer_files/packer_template_msi.json"
    packer_config_filepath               = "./shared_image_gallery/100-packer_managed_identity/packer_files/packer_config_msi.json"
    packer_configuration_remote_filepath = "/tmp/packer/packer_config_msi.json"
    vm_key                               = "packer_vm"
    admin_username                       = "adminuser"
    keyvault_key                         = "packer"
    type                                 = "ssh"
    timeout                              = "20m"
    port                                 = "22"
    public_ip_address_key                = "packer_vm_pip"
    lz_key                               = "examples"
    managed_image_name                   = "myImage"
    resource_group_key                   = "sig" #for managed_image_resource_group_name
    os_type                              = "Linux"
    image_publisher                      = "Canonical"
    image_offer                          = "UbuntuServer"
    image_sku                            = "16.04-LTS"
    location                             = "southeastasia"
    vm_size                              = "Standard_A2_v2"
    ansible_playbook_path                = "/tmp/packer/ansible-ping.yml"
    shared_image_gallery_destination = {
      gallery_key         = "gallery1"
      image_key           = "image1"
      image_version       = "1.0.0"
      resource_group_key  = "sig"
      replication_regions = "southeastasia"
    }
  }
}