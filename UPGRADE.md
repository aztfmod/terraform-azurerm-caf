# Upgrade notes

When upgrading to a newer version of the CAF module, some configuration structures must be updated before applying the modifications.

## 5.7.0

If you are running then module inside rover, the minimum version is 1.1.x. Lower versions not supported anymore.

### Expected resources destroy

When you update to this version, you will notice multiple ```azurecaf_name```  resources being destroyed. This is normal and expected as we have migrated from resource to data for many of the names being generated or used by caf module. This improves visibility at the ```plan``` time as now many names will be calculated at ```plan``` time and uses less resources in the state file.

```hcl
  # module.example.module.virtual_machines["example_vm1"].azurecaf_name.windows["windows"] will be destroyed
  # (because azurecaf_name.windows is not in configuration)
  - resource "azurecaf_name" "windows" {
      - clean_input   = true -> null
      - id            = "twiuobmdpnguvacs" -> null
      - name          = "vm2" -> null
      - passthrough   = false -> null
      - prefixes      = [
          - "hdag",
        ] -> null
      - random_length = 0 -> null
      - resource_type = "azurerm_windows_virtual_machine" -> null
      - result        = "hdag-vm-vm2" -> null
      - results       = {} -> null
      - separator     = "-" -> null
      - use_slug      = true -> null
    }

Plan: 0 to add, 2 to change, 3 to destroy.
```

Other resources updates needed:
- application gateway
```priority``` field now mandatory if you are using ```*v2``` SKU as per [3.44.1](https://registry.terraform.io/providers/hashicorp/azurerm/3.44.1/docs/resources/application_gateway)

- public ip
Change in the provider from [2.99](https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/public_ip) to [3.44.1](https://registry.terraform.io/providers/hashicorp/azurerm/3.44.1/docs/resources/public_ip):
- ```availability_zone``` becomes ```zones``` and nolonger supports the arguments ```No-Zone```, ```Zone-Redundant```. If you have configuration files using the availability_zone argument, you will need to adjust it using the zones argument with the right value.

- vpn_gateway_connections:
  - The deprecated field ```propagated_route_tables``` will be removed in favour of the ```propagated_route_table``` property. If you've been using ```propagated_route_tables```, rename with the new name ```propagated_route_table```.

## 5.6.0

Version 5.6.0 includes support for azurerm 2.98 which requires your attention if you are deploying the following components:

- signal_r:
  - The ```features``` block is deprecated, favor of use ```connectivity_logs_enabled```, ```messaging_logs_enabled```, ```live_trace_enabled``` and ```service_mode``` instead. Module has been updated to reflect that. You must update the settings in your configuration file accordingly.

- data factory:
  - The `data_factory_name` reference method is deprecated in favour of `data_factory_id` and has been removed.
  - If you are referencing literals for data factory name inside ```data_factory.datasets``` (azure_blob, cosmosdb_sqlapi, delimited_text, http, json, mysql, postgresql, sql_server_table) or ```data_factory.linked_services``` (azure_blob_storage, cosmosdb, web, mysql, postgresql, key_vault) you will need to update to use the ```id``` attribute instead of ```name```.
  - **If you are referencing objects with ```key``` and ```lz_key``` inside your model, you dont need to update anything.**

- service bus:
  - The `namespace_name` field is deprecated in favour of `namespace_id` and will be removed in version 3.0 of the AzureRM provider.
  - The `topic_name` field is deprecated in favour of `topic_id` and will be removed in version 3.0 of the AzureRM provider.
  - The `subscription_name` field is deprecated in favour of `subscription_id` and will be removed in version 3.0 of the AzureRM provider.
  - **If you are referencing objects with ```key``` and ```lz_key``` inside your model, you dont need to update anything.**

- apim:
  - The ```proxy``` block is deprecated in favour of `gateways` to support multiple gateways. See example apim/109

from
```hcl
api_management_custom_domain = {
  apimcd1 = {
    api_management = {
      key = "apim1"
    }
    proxy = {
      host_name = "api.example.com"
      key_vault_certificate = {
        certificate_request_key = "example"
      }
    }
  }
}
```

to

```hcl
api_management_custom_domain = {
  apimcd1 = {
    api_management = {
      key = "apim1"
    }
    gateways = {
      gw1 = {
        {
          host_name = "api.example.com"
          key_vault_certificate = {
            certificate_request_key = "example"
          }
        }
      }
    }
  }
}
```

- azure virtual desktop:
  - azurerm 2.97 addedd support for new token method - azurerm_virtual_desktop_host_pool_registration_info - updated and should be transparent.

- azurerm_network_watcher_flow_log:
  - the ```name``` attribute has been added and is mandatory for each network watcher flow log. Changing this forces a new resource to be created so this is expected to be a breaking change for existing azurerm_network_watcher_flow_log.

- network security groups:
  - refactoring for reliability will cause previously created NSG to be delegated and recreated. This will create a very temporary disconnection.


## 5.5.0

Version 5.5.0 deprecates support for Terraform 0.13 and 0.14 as we introduce provider configuration aliases which were supported started on Terraform 0.15.
Configuration file format should remain the same for 5.5.x as per 5.4.x.

- When you call the module as standalone, you will need to update the provider initialization as per:
```hcl
provider "azurerm" {
  alias = "vhub"
}
```
- This update is already included in landing zones starting version 2112.0.


## 5.4.5

Upgrade to 5.4.5 includes support azurerm 2.81.0 provider and implements the following changes:

- Deprecation of client_affinity_enabled attribute for the azurerm_function_app object. This option is nolonger configurable and the property is commented in the code.

## 5.4.4

Due to a regression in the Terraform provider >2.78, this update is not capable of cross-tenant, cross-subscriptions peering between vhub and vwans. This is available in 5.4.3 and will be fixed in 5.5.0.

## 5.4.0

Upgrade to 5.4.0 includes support azurerm 2.64.0 provider and implements the following changes:
- Updated georeplications structure for Azure Container Registry configuration file.
- Updated structure for Azure Front Door configuration file.
- Updated parameter for Azure Public IP address.
- Updated RBAC structures that will in-place update RBAC assignement. This will create new model RBAC and delete old model RBAC assignments and therefore should not disrupt any operation.

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

### Update for public IP address
The parameter ```zone``` is deprecated and replaced by ```availability_zone``` in the provider.

In previous versions, ```var.zones``` was a list, we recommend that you migrate to use ```availability_zone``` as a string parameter. If not, we will try to cast as a string the first element of  ```var.zones```. For more reference on the possible values: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip


## 5.3.0

The structure for Network Security Group has evolved. You will need to update the structure and we recommend you opt-in for the ```version = 1``` of Network Security Group, which allows standalone NSG configuration (outside of a Virtual Network) and direct NIC stitching.


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
