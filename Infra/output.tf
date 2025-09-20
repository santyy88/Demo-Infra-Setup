output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "key_vault_uri" {
  value = azurerm_key_vault.kv.vault_uri
}

