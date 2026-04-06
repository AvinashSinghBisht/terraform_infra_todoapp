resource "azurerm_storage_account" "storage_account" {
  name                     = var.sa_name // "storageaccountname"
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = var.tags
}