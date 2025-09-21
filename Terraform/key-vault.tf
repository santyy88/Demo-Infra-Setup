resource "azurerm_key_vault" "kv" {
  name                        = var.key_vault_name
  location                    = var.location
  resource_group_name         = azurerm_resource_group.rg.name
  tenant_id                   = var.tenant_id
  sku_name                    = "standard"

  # Enable soft delete (recommended for production)
  soft_delete_enabled         = true

  # Purge protection: recommended to set true in prod for full protection
  purge_protection_enabled    = false

  # Access policies: empty for now; can be managed separately or via RBAC
  # Default network access: deny by default for security
  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
  }

  tags = {
    environment = "dev"
    project     = "Demo-Infra-Setup"
  }
}
