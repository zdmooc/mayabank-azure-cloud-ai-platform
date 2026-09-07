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
    Application = "mayabank-observability"
    Environment = "lab"
    Owner       = "architecture"
    CostCenter  = "training"
    ManagedBy   = "terraform"
  }
}

resource "azurerm_resource_group" "this" {
  name     = "rg-mbk-observability-lab"
  location = var.location
  tags     = local.tags
}

resource "azurerm_log_analytics_workspace" "this" {
  name                = "law-mbk-lab"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = local.tags
}

output "workspace_id" {
  value = azurerm_log_analytics_workspace.this.id
}
