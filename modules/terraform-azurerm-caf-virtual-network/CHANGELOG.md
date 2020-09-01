## v3.1.0 (July 2020)

IMPROVEMENTS:

* **improvement:** Support for Terraform 013 ([24](https://github.com/aztfmod/terraform-azurerm-caf-virtual-network/issues/24))


## v3.0.0 (June 2020)

**breaking changes:** Introduces breaking changes in the input/output variable

IMPROVEMENTS:

* **improvement:** Remove deprecated address_prefix variable for the subnet in favour of address_prefixes (requires azurem 2.8.0 and above) ([18](https://github.com/aztfmod/terraform-azurerm-caf-virtual-network/issues/18))
* **improvement:** Added custom NSG name option ([21](https://github.com/aztfmod/terraform-azurerm-caf-virtual-network/issues/21))
* **improvement:** Added additonal configuration options for NSG ([21](https://github.com/aztfmod/terraform-azurerm-caf-virtual-network/issues/21))


## v2.0.1 (June 2020)

IMPROVEMENTS:

* **bug fix:** subnet output now outputs subnet and special subnet ([20] (https://github.com/aztfmod/terraform-azurerm-caf-virtual-network/issues/20))


## v2.0 (March 2020)

IMPROVEMENTS:

* **improvement:** Add support for azurecaf provider for naming convention ([15](https://github.com/aztfmod/terraform-azurerm-caf-virtual-network/issues/15))
* **improvement:** Change virtual_network_rg input variable name to resource_group_name


## v1.2 (March 2020)

IMPROVEMENTS:

* **improvement:** Get ddos_id as optional argument at module call ([13](https://github.com/aztfmod/terraform-azurerm-caf-virtual-network/issues/13))


## v1.1 (February 2020)

BUGS:

* **bug fix:** Issue with provider azurerm 2.0 ([#10](https://github.com/aztfmod/terraform-azurerm-caf-virtual-network/issues/10))

## v1.0 (January 2020)

FEATURES:

* **new feature:**  Add support for traffic analytics and Network flows ([#4](https://github.com/aztfmod/terraform-azurerm-caf-virtual-network/issues/4))
* **new feature:**  Add support for naming convention ([#5](https://github.com/aztfmod/terraform-azurerm-caf-virtual-network/issues/5))
* **new feature:**  Add support for private link policies on virtual subnets ([#8](https://github.com/aztfmod/terraform-azurerm-caf-virtual-network/issues/8)) 
* **new feature:**  Add examples for: Delegation, Simple Vnet, Simple Vnet with network watcher ([#6](https://github.com/aztfmod/terraform-azurerm-caf-virtual-network/issues/6))

IMPROVEMENTS:

BUGS:
* **bug fix:** Fix bug when a subnet has no NSG section declared, you cant create the Vnet ([#7](https://github.com/aztfmod/terraform-azurerm-caf-virtual-network/issues/7)) 
* **bug fix:** Support for eventhub logging is now optionnal ([#3](https://github.com/aztfmod/terraform-azurerm-caf-virtual-network/issues/3)) 
