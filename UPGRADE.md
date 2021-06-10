# Upgrade notes

When ugrading to a newer version of the CAF module, some configuration structures must be updated before applying the modifications.

## 5.4.0

Upgrade to 5.4.0 includes support for:
- Updated georeplications structure for Azure Container Registry configuration file.
- Updated structure for Azure Front Door configuration file.

### Update for georeplications structure for ACR
The georeplications argument has replaced georeplication_locations in azurerm 2.57.0. Accordingly you need to change the configuration file from 

```
georeplication_region_keys = ["region2", "region3"]
```
to 
```
 georeplications = {
       region2 = {
         tags = {
           region = "eastasia"
           type   = "acr_replica"
         }
       }
       region3 = {
         tags = {
           region = "westeurope"
           type   = "acr_replica"
         }
      }
     }
```

### Update structure for Azure Front Door
The logic has moved out from the nested structure 

```
resource "azurerm_frontdoor" "frontdoor" {
  ....
      dynamic "custom_https_configuration" {
        ...
      }
}
```

to the standalone resource creation.

```
resource "azurerm_frontdoor_custom_https_configuration" "frontdoor" {
  ...
}
```
This should not require a restructure of the configuration file.



## 4.21.0

### Virtual machines
configuration path:
```hcl
var.virtual_machines/<key>/virtual_machine_settings/windows/
```

Example of the updated sturcture
/examples/compute/virtual_machine/211-vm-bastion-winrm-agents/virtual_machines.tfvars

Replace
```hcl
admin_user_key = "vm-win-admin-username"
```

by
```hcl
admin_username_key = "vm-win-admin-username"
```