[![Gitter](https://badges.gitter.im/aztfmod/community.svg)](https://gitter.im/aztfmod/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)

# Deploys Shared Image Gallery and automates Image building process
This module creates the following resources

1. Shared Image Galleries - Shared Image Galleries are repository for your VM Images

2. Image Definitions - Image definitions are a logical grouping for versions of an image. The image definition holds information about why the image was created, what OS it is for, and other information about using the image.

3. Image Versions - Will be provisioned using Packer. An image version is what you use to create a VM. You can have multiple versions of an image as needed for your environment.

4. VM Images - Will be provisioned using Packer


The Image Building Process has three steps:

1. Create Shared Image Gallery/Galleries and Image Definition/Definitions using Terraform. The Script to provision these Services is in the root module (/shared_image_gallery.tf)
2. Create a Packer template by rendering Terraform variables.
2. Specify Image Version and create actual VM Image using Packer.The Packer scripts are kept in a sub-module (/modules/shared_image_gallery/packer). As of now, one script placed for creating a Custom image sourced from Marketplace base images. More scripts are coming soon)


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

In this workflow, we will use Terraform modules to create the above mentioned services. Once these Service are provisioned, the values will be fed to the Packer configuration automatically.

The packer scripts are tested with Packer-1.6.4

*Note: The Packer script is written in JSON format, as the Terraform template_file function supports only JSON and YAML rendering.*

Also, Packer client requires an App Registration. Using azuread/applications modules, following  values in need to be created:

- ClientID
- ClientSecret

Plus, the following values can be retrieved from client_config function (part of base launchpad operation)

- TenantID
- SubscriptionID


The App registration part can be included in any level of your choice. We would recommend, include it in the current level with the password validity of 1 day, as the App usage is one-off task.

## Providers

| Name | Version |
|------|---------|
| azurecaf | 1.1.7 |
| azurerm | n/a |

##  Input Syntax (for creating Shared Image Gallery and Image Definitions)

Create resource group(s) as required

```hcl
resource_groups = {
  <resource_group_key> = {
    name = "<string>"
  }
}
```

Create a Keyvault to store the App ID and Secret

```hcl
keyvaults = {
  <kv_key> = {
    name                = "<string>"
    resource_group_key  = "<string>" #refer resource group block
    sku_name            = "<string>" #refer Keyvault documentation
    soft_delete_enabled = true/false
    tags = {
      tfstate = "<string>" #level0/1/2
    }
    creation_policies = {
      logged_in_user = {
        # if the key is set to "logged_in_user" add the user running terraform in the keyvault policy
        # More examples in /examples/keyvault
        # The following is sample permission set. Follow least-priviledge model
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
    }
  }
}
```
Set  Keyvault Access Policies here.
```hcl
keyvault_access_policies_azuread_apps = {
  <kv_key> = {
    <key> = {
      azuread_app_key    = "<string>" #refer azuread_app block
      # The following is sample permission. Follow least-priviledge model
      secret_permissions = ["Set", "Get", "List", "Delete"]
    }
  }
}
```

creates an Azure AD registration for the Packer client

```hcl
azuread_apps = {
  <app_key> = {
    useprefix                    = true/false
    application_name             = "<string>"
    password_expire_in_days      = %d #number of days
    app_role_assignment_required = true/false
    keyvaults = {
      <kv_key> = {
        secret_prefix = "<string>"
      }
    }
    # Store the ${secret_prefix}-client-id, ${secret_prefix}-client-secret...
    # Set the policy during the creation process of the launchpad
  }
}
```

Assigns a role for the Packer client. Follow the least priviledge model
```hcl
azuread_roles = {
  <app_key> = {
    roles = [
      "Contributor"  #built-in role
    ]
  }
}

role_mapping = {
  built_in_role_mapping = {
    subscriptions = {
      logged_in_subscription = {
        "Contributor" = {
          azuread_apps = {
            keys = ["<app_key>"]
          }
        }
      }
    }
  }
}
```
Created Shared Image Galleries
```hcl
shared_image_gallery = {
  galleries = {
    gallery1 = {
      name               = "<string>"
      resource_group_key = "<string>"
      description        = "<string>"
    }
  }
```
Created Image Definitions within Shared Image Galleries
```hcl
  image_definition = {
    image1 = {
      name               = "<string>"
      gallery_key        = "<string>"
      resource_group_key = "<string>"
      os_type            = "<string>"
      publisher          = "<string>"
      offer              = "<string>"
      sku                = "<string>"
    }
  }
}
```
Input for the Packer configuration
```hcl
packer = {
  build1 = {
    packer_template_filepath      = "<filepath>"
    packer_configuration_filepath = "/<filepath>"
    azuread_apps_key              = "<app_key>"
    secret_prefix                 = "<string>"
    keyvault_key                  = "<kv_key"
    managed_image_name            = "<string>"
    resource_group_key            = "<resource_group_key>" # for managed_image_resource_group_name
    os_type                       = "<string>" # Linux/Windows
    image_publisher               = "<string>" # marketplace
    image_offer                   = "<string>" # marketplace
    image_sku                     = "<string>" # marketplace
    location                      = "<string>" # must be valid Azure region
    vm_size                       = "<string>" # Azure VM Size
    ansible_playbook_path         = "<filepath>"
    shared_image_gallery_destination = {
      gallery_key         = "<string>"
      image_key           = "<string>"
      image_version       = "<string>"
      resource_group_key  = "<resource_group_key>"
      replication_regions = "<string>"
    }
  }
}

```