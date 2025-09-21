resource "azurerm_firewall_policy" "fw_policy" {
  name                = "midas-fw-policy"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
}

