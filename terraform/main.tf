provider "azurerm" {
    features {}
    subscription_id =var.subscription_id 
}

resource "azurerm_resource_group" "example" {
  name     = "Devops_Project"
  location = "Australia Central"
}

resource "azurerm_kubernetes_cluster" "example" {
  name                = "Devops_Project"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  dns_prefix          = "exampleaks1"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "standard_d2_v4"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Devops_Project"
  }
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.example.kube_config[0].client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.example.kube_config_raw

  sensitive = true 
}