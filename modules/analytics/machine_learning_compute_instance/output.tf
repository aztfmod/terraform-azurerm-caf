output "id" {
  value       = azurerm_machine_learning_compute_instance.mlci.id
  description = "The ID of the Machine Learning Compute Instance."
}
output "identity" {
  value       = azurerm_machine_learning_compute_instance.mlci.identity
  description = "An `identity` block as defined below, which contains the Managed Service Identity information for this Machine Learning Compute Instance."
}
output "ssh" {
  value       = azurerm_machine_learning_compute_instance.mlci.ssh
  description = "An `ssh` block as defined below, which specifies policy and settings for SSH access for this Machine Learning Compute Instance."
}
