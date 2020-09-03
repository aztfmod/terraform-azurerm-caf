output id {
  value = azurerm_kubernetes_cluster.aks.id
}

output cluster_name {
  value = azurecaf_naming_convention.aks.result
}

output resource_group_name {
  value = var.resource_group.name
}

output aks_kubeconfig_cmd {
  value = format("az aks get-credentials --name %s --resource-group %s --overwrite-existing", azurecaf_naming_convention.aks.result, var.resource_group.name)
}

output aks_kubeconfig_admin_cmd {
  value = format("az aks get-credentials --name %s --resource-group %s --overwrite-existing --admin", azurecaf_naming_convention.aks.result, var.resource_group.name)
}

output kubelet_identity {
  description = "User-defined Managed Identity assigned to the Kubelets"
  value       = azurerm_kubernetes_cluster.aks.kubelet_identity
}

output identity {
  description = "System assigned identity which is used by master components"
  value       = azurerm_kubernetes_cluster.aks.identity
}

output kube_admin_config_raw {
  value = azurerm_kubernetes_cluster.aks.kube_admin_config_raw
}

output rbac_id {
  value = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}