

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = var.location
  resource_group_name = var.rg_name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name       = "default"
    node_count = var.node_count  // Default value as 1
    vm_size    = var.vm_size     // "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}


# output "client_certificate" {
#   value     = azurerm_kubernetes_cluster.example.kube_config[0].client_certificate
#   sensitive = true
# }

# output "kube_config" {
#   value = azurerm_kubernetes_cluster.example.kube_config_raw

#   sensitive = true
# }