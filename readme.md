[![VScodespaces](https://img.shields.io/endpoint?url=https%3A%2F%2Faka.ms%2Fvso-badge)](https://online.visualstudio.com/environments/new?name=terraform-azurerm-caf-landingzone-modules&repo=aztfmod/terraform-azurerm-caf-landingzone-modules)

# Azure Cloud Adoption Framework landing zones for Terraform vnext preview

Microsoft [Cloud Adoption Framework for Azure](https://aka.ms/caf) provides you with guidance and best practices to adopt Azure.

A landing zone is a segment of a cloud environment, that has been preprovisioned through code, and is dedicated to the support of one or more workloads. Landing zones provide access to foundational tools and controls to establish a compliant place to innovate and build new workloads in the cloud, or to migrate existing workloads to the cloud. Landing zones use defined sets of cloud services and best practices to set you up for success.

## Vnext differentiated approach

This vnext is relying extensively on Terraform 0.13 capabilities (module iterations, conditional modules, variables validation, etc.). Those new features allow more complex and more dynamic code composition. The following concepts are used:

* **Flexible fundations to meet customer needs**: everything is customizable at all layers.
* **Key-based configuration and customization**: all configuration objects will call each other based on the object keys.
* **Iteration-based objects deployment**: a landing zone calls all its modules, iterating on complex objects for technical resources deployment.

## Testing vnext

1. Prerequisites are the same as for current version of landing zones, please setup your environment using the following guide: https://github.com/Azure/caf-terraform-landingzones/blob/master/documentation/getting_started/getting_started.md 

2. Log in the subscription with the rover:

```bash
rover login
### you can alternatively specify the tenant space and subscription ID on command line arguments:
rover login --tenant <tenant_name>.onmicrosoft.com -s <subscription_id>
```

3. Deploy the basic launchpad (working on AIRS):

```bash
rover -lz /tf/caf/landingzones/caf_launchpad -launchpad -var-file /tf/caf/landingzones/caf_launchpad/scenario/100/configuration.tfvars -w tfstate -a apply
```

Once completed you would see 2 resource groups in your subscription. The scenario 100 is pretty basic and include the minimum to get the terraform remote state management working.

4. Upgrade to advanced launchpad (if you have Azure AD permissions - not working on AIRS):

```bash
rover -lz /tf/caf/landingzones/caf_launchpad -launchpad -var-file /tf/caf/landingzones/caf_launchpad/scenario/200/configuration.tfvars -w tfstate -a apply
```

5. Deploy the caf_foundations. This is currently mostly a stub, but will implement enterprise management groups, policies, alerts, etc.:

```bash
rover -lz /tf/caf/landingzones/caf_foundations -w tfstate -a apply
```

6. Deploy a networking scenario:

```bash
rover -lz /tf/caf/landingzones/caf_networking/ -var-file /tf/caf/landingzones/caf_networking/scenario/110-aks-private/configuration.tfvars -w tfstate -a apply
```

## Example levels

We classified the various examples in this repo:

| level | functionalities                                                                               | supported environments                     |
|-------|-----------------------------------------------------------------------------------------------|--------------------------------------------|
| 100   | basic functionalities and features, for demo and simple POC                                   | works in AIRS                              |
| 200   | intermediate functionalities includes RBAC features                                           | may not work in AIRS, need AAD permissions |
| 300   | advanced functionalities, multi region support, includes RBAC features                        | not working in AIRS, need AAD permissions  |  
| 400   | advanced functionalities, multi region support, includes RBAC features and security hardening | not working in AIRS, need AAD permissions  |

## Related repositories

| Repo                                                                                              | Description                                                |
|---------------------------------------------------------------------------------------------------|------------------------------------------------------------|
| [caf-terraform-landingzones](https://github.com/azure/caf-terraform-landingzones) (You are here!) | landing zones repo with sample and core documentations     |
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
