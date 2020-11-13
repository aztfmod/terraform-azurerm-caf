level = "level2"

landingzone_name = "shared_services"

resource_groups = {
  sig = {
    name = "sig"
  }
}

azuread_apps = {
  packer_client = {
    useprefix               = true
    application_name        = "packer-client"
    password_expire_in_days = 1
    # Store the ${secret_prefix}-client-id, ${secret_prefix}-client-secret...
    # Set the policy during the creation process of the launchpad
  }
}

azuread_roles = {
  packer_client = {
    roles = [
      "Contributor"
    ]
  }
} 

shared_image_gallery = {

  galleries = {
    gallery1 ={
      name = "test1"
      resource_group_key = "sig"
      description = "some description"
    }
  }

  image_definition = {
    image1 = {
      name = "image1"
      gallery_key = "gallery1"
      resource_group_key = "sig"
      os_type = "Linux"
      publisher = "MyCompany"
      offer     = "WebServer"
      sku       = "2020.1"
    }
  }
  
}

packer = {
    build1 = {
      packer_template_filepath = "/tf/caf/modules/shared_image_gallery/packer/packer_template.json"
      packer_configuration_filepath = "/tf/caf/modules/shared_image_gallery/packer/deploy.json"
      azuread_apps_key = "packer_client"
      managed_image_name = "myImage"
      resource_group_key = "sig" #for managed_image_resource_group_name
      os_type = "Linux"
      image_publisher = "Canonical"
      image_offer = "UbuntuServer"
      image_sku = "16.04-LTS"
      location = "southeastasia"
      vm_size = "Standard_DS1_v2"
      ansible_playbook_path = "/tf/caf/public/landingzones/caf_shared_services/scenario/100/ansible-ping.yml"

      shared_image_gallery_destination = {
        gallery_key = "gallery1"
        image_key = "image1"
        image_version = "1.0.0"
        resource_group_key = "sig"
        replication_regions = "southeastasia"
      }
    }
  
 }

