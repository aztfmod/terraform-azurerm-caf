[![Gitter](https://badges.gitter.im/aztfmod/community.svg)](https://gitter.im/aztfmod/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)

# Deploys Shared Image Gallery and automates Image building process
This module creates the following resources

1. Shared Image Galleries - Shared Image Galleries are repository for your VM Images

2. Image Definitions - Image definitions are a logical grouping for versions of an image. The image definition holds information about why the image was created, what OS it is for, and other information about using the image.

3. Image Versions - Will be provisioned using Packer. An image version is what you use to create a VM. You can have multiple versions of an image as needed for your environment.

4. VM Images - Will be provisioned using Packer


The Image Building Process has two steps:

1. Create Shared Image Gallery/Galleries and Image Definition/Definitions using Terraform. The Script to provision these Services is in the root module (/shared_image_gallery.tf)
2. Specify Image Version and create actual VM Image using Packer.The Packer scripts are kept in a sub-module (/modules/shared_image_gallery/packer). As of now, two scripts are placed for different scenarios. More scripts are coming soon)


*Note: Azure has a native Image Building Service that's in preview as of now. As soon as  the Service becomes generally available, we will replace Packer in this workflow.*

Reference Links :

For Linux VMs: https://docs.microsoft.com/en-us/azure/virtual-machines/linux/shared-image-galleries

For Windows VMs : https://docs.microsoft.com/en-us/azure/virtual-machines/windows/shared-image-galleries

Packer Documentation : https://www.packer.io/docs/builders/azure/arm

Azure Image Builder : https://docs.microsoft.com/en-us/azure/virtual-machines/linux/image-builder-overview


## Requirements

To provision Images using Packer, the following Services must be created in advance:
- Shared Image Gallery
- Image Definition
- A Service Principal for the Packer Client to access Azure Services

In this workflow, we will use Terraform modules to create the above mentioned services. Once these Service are provisioned, the values will be fed to the Packer configuration manually.

The packer scripts are tested with Packer-1.6.4

To maintain uniformity, the Packer scripts in this module are written in HCL2 syntax. If you have exisiting Packer scrripts in JSON format, please use the hcl2_upgrade command to convert them to HCL2 Syntax. Ref: https://www.packer.io/docs/commands/hcl2_upgrade

Also, Packer client requires an App Registration. Using azuread/applications modules, generate the following values in Advance.

- ClientID
- ClientSecret

Plus, note the following values (can be done programmatically or from the Azure Portal):

- TenantID
- SubscriptionID


The App registration part can be included in any level of your choice. We would recommend, include it in the current level with the password validity of 1 day, as the App usage is one-off task.

## Providers

| Name | Version |
|------|---------|
| azurecaf | n/a |
| azurerm | n/a |

##  Input Syntax (for creating Shared Image Gallery and Image Definitions)
```hcl
resource_groups = {
  key = {
    name = "<string>"
  }
  # repeat the block to create resource groups
}

shared_image_gallery = {

  galleries = {
    key ={
      name = "<string>" # must be in specific format. refer Product Docs
      resource_group_key = "<string>"
      description = "<string>"
    }
    # repeat the block to create multiple galleries

  }

  image_definition = {
    key = {
      name = "<string>"
      gallery_key = "<string>" # point to the gallery created above
      resource_group_key = "<string>"  # point to the Resource Group created above
      os_type = "<string>" # Must be either Windows or Linux
      publisher = "<string>"
      offer     = "<string>"
      sku       = "<string>" # must be in specific format. refer Product Docs
      }
      # repeat the block to create multiple Image Definitions
  }

}
# the following block must present in your configuration before to use Packer
packer = {
  use_packer = true/false # Important : keep it false during the first run
  packer_file_path = "<string_path>"
  packer_configuration_file_path = "<string_path>"

// once galleries and definitions are created, change the use_packer value to True and re-run. This is important due to Packer's dependancy on Shared Image Galleries and Definitions.//

}
```

