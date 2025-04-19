provider "azurerm" {
  features {}
}

# 1. Resource Group
resource "azurerm_resource_group" "example" {
  name     = "my-resource-group"
  location = "East US"  # Where in the world do you want the resources?
}

# 2. Azure Kubernetes Service (AKS)
resource "azurerm_kubernetes_cluster" "example" {
  name                = "my-aks-cluster"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  dns_prefix          = "myaks"

  default_node_pool {
    name       = "default"
    node_count = 3      # How many containers (nodes) do you want?
    vm_size    = "Standard_DS2_v2"  # The type of machine you want to run in the cloud.
  }
}

# 3. Azure Cosmos DB (Database)
resource "azurerm_cosmosdb_account" "example" {
  name                = "mycosmosdb"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"
}
