[![VScodespaces](https://img.shields.io/endpoint?url=https%3A%2F%2Faka.ms%2Fvso-badge)](https://online.visualstudio.com/environments/new?name=terraform-azurerm-caf-landingzone-modules&repo=aztfmod/terraform-azurerm-caf)

# Cloud Adoption Framework for Azure - Terraform module

Microsoft [Cloud Adoption Framework for Azure](https://aka.ms/caf) provides you with guidance and best practices to adopt Azure. This module is used by the CAF landing zones to provision resources in Azure subscription. 

## Getting started

This module can be used to create resources directly or called from a landing zone.
It can be invoked directly from the [Terraform registry](https://registry.terraform.io/modules/aztfmod/caf/azurerm/)

```terraform
module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "~>0.4.0"
  # insert the 7 required variables here
}
```

## Prerequisites

- Setup your **environment** using the following guide [Getting Started](https://github.com/Azure/caf-terraform-landingzones/blob/master/documentation/getting_started/getting_started.md) or you can alternatively use [Visual Studio Code Online]((https://online.visualstudio.com/environments/new?name=terraform-azurerm-caf&repo=aztfmod/terraform-azurerm-caf)
) or GitHub Codespaces.
- Access to an **Azure subscription** where you have **Owner** role.


## Developing and testing module for landing zones

If you want to test, develop this module for landing zones integration, please follow the steps:

1. Clone the Azure landing zones repo

```bash
git clone --branch 2010.0.0 https://github.com/Azure/caf-terraform-landingzones.git /tf/caf/public
```

2. Log in the subscription with the rover

```bash
rover login
### you can alternatively specify the tenant space and subscription ID on command line arguments:
rover login --tenant <tenant_name>.onmicrosoft.com -s <subscription_id>
```

3. Deploy the basic launchpad

```bash
rover -lz /tf/caf/public/landingzones/caf_launchpad \
-launchpad \
-var-folder /tf/caf/public/landingzones/caf_launchpad/scenario/100 \
-a apply
```

4. Deploy the caf_foundations landing zones

```bash
rover -lz /tf/caf/public/landingzones/caf_foundations \
-level level1 \
-a apply
```

5. Deploy a networking scenario:

```bash
rover -lz /tf/caf/public/landingzones/caf_networking/ \
-var-folder /tf/caf/public/landingzones/caf_networking/scenario/100-single-region-hub \
-level level2 \
-a apply
```

## Deploying examples

Once you have setup the environment up to stage 3 (have finished the deployment of the launchpad), you can also deploy examples using the following syntax:

```bash
rover -lz /tf/caf/examples \
-var-folder /tf/caf/examples/<path of the example> \
-a plan|apply
```

We categorize the various examples in this repo as follow:

| level | scenario                                                                                                                               | requirements                                       |
|-------|----------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------|
| 100   | Start with this one! basic functionalities and features, no RBAC or security hardening - for demo and simple POC                       | working on any subscription with Owner permissions |
| 200   | intermediate functionalities includes diagnostics features and Azure Active Directory groups                                           | may need custom AAD permissions                    |
| 300   | advanced functionalities, includes RBAC features, virtual network and private link scenario and reduced portal view for hardened items | need custom AAD permissions                        |
| 400   | advanced functionalities, includes RBAC features and security hardening                                                                | need custom AAD permissions                        |

## Related repositories

| Repo                                                                              | Description                                            |
|-----------------------------------------------------------------------------------|--------------------------------------------------------|
| [caf-terraform-landingzones](https://github.com/azure/caf-terraform-landingzones) | landing zones repo with sample and core documentations |
| [rover](https://github.com/aztfmod/rover)                                         | devops toolset for operating landing zones             |
| [azure_caf_provider](https://github.com/aztfmod/terraform-provider-azurecaf)      | custom provider for naming conventions                 |
| [Azure Kubernetes Services](https://github.com/aztfmod/landingzone_aks)           | Azure Kubernetes Services solutions                    |
| [Data and Analytics](https://github.com/aztfmod/landingzone_data_analytics)       | Data and Analytics solutions                           |
| SAP on Azure                                                                      | Coming soon...                                         |
| Shared Image Gallery                                                              | Coming soon...                                         |

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
