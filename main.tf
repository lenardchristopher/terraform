# Configure the Azure Provider
provider "azurerm" {
  version = "=2.0.0"
  features {}
}

resource "azurerm_resource_group" "test_resource_group" {
  name     = "test-rg"
  location = "Central US"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "test-cluster"
  location            = azurerm_resource_group.test_resource_group.location
  resource_group_name = azurerm_resource_group.test_resource_group.name
  dns_prefix          = "clenard"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  service_principal {
    client_id     = var.service_principal_id
    client_secret = var.service_principal_secret
  }
}

resource "azurerm_storage_account" "storage_account" {
  name                     = "cltest-generalstorage"
  resource_group_name      = azurerm_resource_group.test_resource_group.name
  location                 = azurerm_resource_group.test_resource_group.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}


output "client_certificate" {
  value = azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_config_raw
}