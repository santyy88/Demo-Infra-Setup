# Azure Service Principal
variable "subscription_id" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "client_id" {
  type = string
}

variable "client_secret" {
  type = string
}

# Location
variable "location" {
  type    = string
  default = "East US"
}

# Resource Group
variable "resource_group_name" {
  type = string
}

# Virtual Network
variable "vnet_name" {
  type = string
}

variable "vnet_address_space" {
  type = list(string)
}

# Subnets
variable "subnet_web" {
  type = list(string)
}

variable "subnet_app" {
  type = list(string)
}

variable "subnet_db" {
  type = list(string)
}

# AKS Cluster
variable "aks_node_count" {
  type    = number
  default = 2
}

variable "aks_node_size" {
  type    = string
  default = "Standard_DS2_v2"
}

# Key Vault
variable "key_vault_name" {
  type = string
}
