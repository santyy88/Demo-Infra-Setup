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

# Azure region
variable "location" {
  type        = string
  description = "Azure region"
  default     = "eastus"
}

# Resource Group
variable "resource_group_name" {
  type    = string
  default = "midas-rg"
}

# Virtual Network
variable "vnet_name" {
  type    = string
  default = "midas-vnet"
}

variable "vnet_address_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}

# Subnets
variable "subnet_web" {
  type    = list(string)
  default = ["10.0.1.0/24"]
}

variable "subnet_app" {
  type    = list(string)
  default = ["10.0.2.0/24"]
}

variable "subnet_db" {
  type    = list(string)
  default = ["10.0.3.0/24"]
}

# AKS Cluster
variable "aks_node_count" {
  type    = number
  default = 1
}

variable "aks_node_size" {
  type    = string
  default = "Standard_B2s"
}

# Key Vault
variable "key_vault_name" {
  type    = string
  default = "midas-kv"
}
