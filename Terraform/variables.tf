variable "subscription_id" {}
variable "tenant_id" {}
variable "client_id" {}
variable "client_secret" {}

variable "location" {
  description = "Azure region"
  default     = "eastus"
}

variable "resource_group_name" {
  default = "midas-rg"
}

variable "vnet_name" {
  default = "midas-vnet"
}

variable "vnet_address_space" {
  default = ["10.0.0.0/16"]
}

variable "subnet_web" {
  default = ["10.0.1.0/24"]
}

variable "subnet_app" {
  default = ["10.0.2.0/24"]
}

variable "subnet_db" {
  default = ["10.0.3.0/24"]
}

variable "aks_node_count" {
  default = 1
}

variable "aks_node_size" {
  default = "Standard_B2s"
}

variable "key_vault_name" {
  default = "midas-kv"
}

