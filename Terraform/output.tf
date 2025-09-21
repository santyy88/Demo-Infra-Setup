# Output the Resource Group name
output "resource_group_name" {
  description = "The name of the Azure Resource Group"
  value       = azurerm_resource_group.rg.name
}

# Output the AKS Cluster name
output "aks_cluster_name" {
  description = "The name of the Azure Kubernetes Service (AKS) cluster"
  value       = azurerm_kubernetes_cluster.aks.name
}

# Output the Key Vault URI
output "key_vault_uri" {
  description = "The URI of the Azure Key Vault"
  value       = azurerm_key_vault.kv.vault_uri
}
