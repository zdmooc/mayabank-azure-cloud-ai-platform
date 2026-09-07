terraform {
  required_version = ">= 1.9, < 2.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

variable "location" {
  type    = string
  default = "francecentral"
}

locals {
  tags = {
    Application = "mayabank-platform"
    Environment = "lab"
    Owner       = "architecture"
    CostCenter  = "training"
    ManagedBy   = "terraform"
  }
}

resource "azurerm_resource_group" "this" {
  name     = "rg-mbk-network-lab"
  location = var.location
  tags     = local.tags
}

resource "azurerm_virtual_network" "hub" {
  name                = "vnet-mbk-hub-lab"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = ["10.10.0.0/16"]
  tags                = local.tags
}

resource "azurerm_subnet" "hub_shared" {
  name                 = "snet-shared"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = ["10.10.1.0/24"]
}

resource "azurerm_virtual_network" "apps" {
  name                = "vnet-mbk-apps-lab"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = ["10.20.0.0/16"]
  tags                = local.tags
}

resource "azurerm_subnet" "apps" {
  name                 = "snet-apps"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.apps.name
  address_prefixes     = ["10.20.1.0/24"]
}

resource "azurerm_virtual_network" "data" {
  name                = "vnet-mbk-data-lab"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = ["10.30.0.0/16"]
  tags                = local.tags
}

resource "azurerm_subnet" "data" {
  name                 = "snet-data"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.data.name
  address_prefixes     = ["10.30.1.0/24"]
}

resource "azurerm_network_security_group" "apps" {
  name                = "nsg-mbk-apps-lab"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  tags                = local.tags
}

resource "azurerm_subnet_network_security_group_association" "apps" {
  subnet_id                 = azurerm_subnet.apps.id
  network_security_group_id = azurerm_network_security_group.apps.id
}

resource "azurerm_virtual_network_peering" "hub_to_apps" {
  name                      = "hub-to-apps"
  resource_group_name       = azurerm_resource_group.this.name
  virtual_network_name      = azurerm_virtual_network.hub.name
  remote_virtual_network_id = azurerm_virtual_network.apps.id
}

resource "azurerm_virtual_network_peering" "apps_to_hub" {
  name                      = "apps-to-hub"
  resource_group_name       = azurerm_resource_group.this.name
  virtual_network_name      = azurerm_virtual_network.apps.name
  remote_virtual_network_id = azurerm_virtual_network.hub.id
}

resource "azurerm_virtual_network_peering" "hub_to_data" {
  name                      = "hub-to-data"
  resource_group_name       = azurerm_resource_group.this.name
  virtual_network_name      = azurerm_virtual_network.hub.name
  remote_virtual_network_id = azurerm_virtual_network.data.id
}

resource "azurerm_virtual_network_peering" "data_to_hub" {
  name                      = "data-to-hub"
  resource_group_name       = azurerm_resource_group.this.name
  virtual_network_name      = azurerm_virtual_network.data.name
  remote_virtual_network_id = azurerm_virtual_network.hub.id
}

resource "azurerm_private_dns_zone" "lab" {
  name                = "privatelink.mayabank.lab"
  resource_group_name = azurerm_resource_group.this.name
  tags                = local.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "hub" {
  name                  = "link-hub"
  resource_group_name   = azurerm_resource_group.this.name
  private_dns_zone_name = azurerm_private_dns_zone.lab.name
  virtual_network_id    = azurerm_virtual_network.hub.id
}

resource "azurerm_private_dns_zone_virtual_network_link" "apps" {
  name                  = "link-apps"
  resource_group_name   = azurerm_resource_group.this.name
  private_dns_zone_name = azurerm_private_dns_zone.lab.name
  virtual_network_id    = azurerm_virtual_network.apps.id
}

output "hub_vnet_id" {
  value = azurerm_virtual_network.hub.id
}

output "apps_vnet_id" {
  value = azurerm_virtual_network.apps.id
}

output "data_vnet_id" {
  value = azurerm_virtual_network.data.id
}
