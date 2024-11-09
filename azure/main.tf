provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "default" {
  name     = "rg"
  location = "Germany West Central"
}

resource "azurerm_kubernetes_cluster" "default" {
  name                = "aks"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  dns_prefix          = "k8s"
  kubernetes_version  = "1.26.3"

  default_node_pool {
    name            = "default"
    node_count      = 3
    vm_size         = "Standard_D2_v2"
  }

  role_based_access_control_enabled = true

  tags = {
    environment = "Demo"
  }
}

resource "azurerm_postgresql_server" "example" {
  name                = "postgresql-server-1"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name

  storage_mb                   = 8000
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = true

  administrator_login          = "psqladmin"
  administrator_login_password = "pass"
  version                      = "14"
  ssl_enforcement_enabled      = true
  sku_name                     = "GP_Gen5_8"
}

resource "azurerm_postgresql_database" "example" {
  name                = "exampledb"
  resource_group_name = azurerm_resource_group.default.name
  server_name         = azurerm_postgresql_server.example.name
  charset             = "UTF8"
  collation           = "English_United States.1252"

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = true
  }
}