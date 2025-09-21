##############################################
# Resource Group
##############################################
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

##############################################
# Virtual Network
##############################################
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

##############################################
# Subnets
##############################################
resource "azurerm_subnet" "web" {
  name                 = "web-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_web
}

resource "azurerm_subnet" "app" {
  name                 = "app-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_app
}

resource "azurerm_subnet" "db" {
  name                 = "db-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_db
}

##############################################
# Key Vault
##############################################
resource "azurerm_key_vault" "kv" {
  name                        = var.key_vault_name
  location                    = var.location
  resource_group_name         = azurerm_resource_group.rg.name
  tenant_id                   = var.tenant_id
  sku_name                    = "standard"
  purge_protection_enabled    = true
  soft_delete_enabled         = true

  network_acls {
    default_action             = "Deny"
    bypass                     = "AzureServices"
  }
}

# Give AKS access to Key Vault via system-assigned identity
resource "azurerm_role_assignment" "aks_kv_access" {
  scope                = azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_kubernetes_cluster.aks.identity[0].principal_id
  depends_on           = [azurerm_kubernetes_cluster.aks]
}

##############################################
# AKS Cluster
##############################################
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-${var.resource_group_name}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "${var.resource_group_name}-aks"

  default_node_pool {
    name           = "default"
    node_count     = var.aks_node_count
    vm_size        = var.aks_node_size
    vnet_subnet_id = azurerm_subnet.app.id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "azure"
    network_policy    = "azure"
    service_cidr      = "10.2.0.0/16"
    dns_service_ip    = "10.2.0.10"
    docker_bridge_cidr = "172.17.0.1/16"
  }

  role_based_access_control {
    enabled = true
  }

  depends_on = [
    azurerm_subnet.app,
    azurerm_virtual_network.vnet
  ]
}

##############################################
# Outputs
##############################################
output "aks_cluster_name" {
  description = "Name of the AKS cluster"
  value       = azurerm_kubernetes_cluster.aks.name
}

output "aks_cluster_resource_group" {
  description = "Resource group of AKS cluster"
  value       = azurerm_kubernetes_cluster.aks.node_resource_group
}

output "key_vault_id" {
  description = "ID of the Key Vault"
  value       = azurerm_key_vault.kv.id
}

output "vnet_id" {
  description = "Virtual Network ID"
  value       = azurerm_virtual_network.vnet.id
}
