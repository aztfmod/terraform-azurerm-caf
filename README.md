[![VScodespaces](https://img.shields.io/endpoint?url=https%3A%2F%2Faka.ms%2Fvso-badge)](https://online.visualstudio.com/environments/new?name=terraform-azurerm-caf-landingzone-modules&repo=aztfmod/terraform-azurerm-caf-landingzone-modules)

# Azure Cloud Adoption Framework - Terraform module

This is a preview of vnext azurerm module for CAF landing zones on Terraform.
Microsoft [Cloud Adoption Framework for Azure](https://aka.ms/caf) provides you with guidance and best practices to adopt Azure.

## Core components

Deploying the core of landing zones will use two elements:

* landing zones repository (https://github.com/Azure/caf-terraform-landingzones): will assemble all components together and do service composition.
* this module, called from the Terraform registry (https://registry.terraform.io/namespaces/aztfmod): will provide all the logic to deploy fundamental components.

This module can be called from landing zones using the Terraform registry: https://registry.terraform.io/modules/aztfmod/caf/azurerm/

```terraform
module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "~>0.2"
  # insert the 7 required variables here
}
```

## Getting started

1. Prerequisites are the same as for current version of landing zones, please setup your environment using the following guide: https://github.com/Azure/caf-terraform-landingzones/blob/master/documentation/getting_started/getting_started.md.

2. Clone the Azure landing zones repo:

```bash
git clone --branch vnext https://github.com/Azure/caf-terraform-landingzones.git /tf/caf/public

```

3. Log in the subscription with the rover:

```bash
rover login
### you can alternatively specify the tenant space and subscription ID on command line arguments:
rover login --tenant <tenant_name>.onmicrosoft.com -s <subscription_id>
```

4. Deploy the basic launchpad:

```bash
rover -lz /tf/caf/public/landingzones/caf_launchpad -launchpad -var-file /tf/caf/public/landingzones/caf_launchpad/scenario/100/configuration.tfvars -a apply
```

Once completed you would see 2 resource groups in your subscription. The scenario 100 is pretty basic and include the minimum to get the terraform remote state management working.

5. Upgrade to advanced launchpad (if you have Azure AD permissions - not working on AIRS):

```bash
rover -lz /tf/caf/public/landingzones/caf_launchpad -launchpad -var-file /tf/caf/public/landingzones/caf_launchpad/scenario/200/configuration.tfvars -a apply
```

6. Deploy the caf_foundations. This is currently mostly a stub, but will implement enterprise management groups, policies, alerts, etc.:

```bash
rover -lz /tf/caf/public/landingzones/caf_foundations -a apply
```

7. Deploy a networking scenario:

```bash
rover -lz /tf/caf/public/landingzones/caf_networking/ -var-file /tf/caf/public/landingzones/caf_networking/scenario/100-single-region-hub/configuration.tfvars -a apply
```

## Coding principles

This vnext is relying extensively on Terraform 0.13 capabilities (module iterations, conditional modules, variables validation, etc.).

Those new features allow more complex and more dynamic code composition. The following concepts are used:

* **No code environment composition**: a landing zone environment can be composed customizing variable files and code must be robust enough to accommodate combinations and composition.
* **Flexible foundations to meet customer needs**: everything is customizable at all layers.
* **Key-based configuration and customization**: all configuration objects will call each other based on the object keys.
* **Iteration-based objects deployment**: a landing zone calls all its modules, iterating on complex objects for technical resources deployment.



## Example levels

We categorize the various examples in this repo as follow:

| level | functionalities                                                                               | supported environments                     |
|-------|-----------------------------------------------------------------------------------------------|--------------------------------------------|
| 100   | basic functionalities and features, no RBAC or security hardening - for demo and simple POC   | working on AIRS subscriptions              |
| 200   | intermediate functionalities includes RBAC features                                           | may not work in AIRS, need AAD permissions |
| 300   | advanced functionalities, multi region support, includes RBAC features                        | not working in AIRS, need AAD permissions  |
| 400   | advanced functionalities, multi region support, includes RBAC features and security hardening | not working in AIRS, need AAD permissions  |


## Landing zone solutions

Once you deploy the core enterprise scale components, you can leverage the following additional solution landing zones:

| Solution                  | URL                                                         |
|---------------------------|-------------------------------------------------------------|
| Azure Kubernetes Services | https://github.com/aztfmod/landingzone_aks                  |
| Data and Analytics        | https://github.com/aztfmod/landingzone_data_analytics       |
| SAP on Azure              | https://github.com/aztfmod/terraform-azurerm-sap            |
| Shared Image Gallery      | https://github.com/aztfmod/landingzone_shared_image_gallery |

To review the enterprise-scale on Terraform landing zone hierarchy model, you can refer to the classic model:

* Hierarchy model: https://github.com/Azure/caf-terraform-landingzones/blob/master/documentation/code_architecture/hierarchy.md
* Delivery model: https://github.com/Azure/caf-terraform-landingzones/blob/master/documentation/delivery/delivery_landingzones.md

## Related repositories

| Repo                                                                                              | Description                                                |
|---------------------------------------------------------------------------------------------------|------------------------------------------------------------|
| [caf-terraform-landingzones](https://github.com/azure/caf-terraform-landingzones)                 | landing zones repo with sample and core documentations     |
| [rover](https://github.com/aztfmod/rover)                                                         | devops toolset for operating landing zones                 |
| [azure_caf_provider](https://github.com/aztfmod/terraform-provider-azurecaf)                      | custom provider for naming conventions                     |
| [modules](https://registry.terraform.io/modules/aztfmod)                                          | set of curated modules available in the Terraform registry |

## Community

Feel free to open an issue for feature or bug, or to submit a PR.

In case you have any question, you can reach out to tf-landingzones at microsoft dot com.

You can also reach us on [Gitter](https://gitter.im/aztfmod/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)

## Contributing

This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit https://cla.opensource.microsoft.com.

When you submit a pull request, a CLA bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., status check, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

## Code of conduct

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.
