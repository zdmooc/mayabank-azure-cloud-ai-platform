terraform {
  required_version = ">= 1.9, < 2.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

variable "location" {
  type    = string
  default = "francecentral"
}

variable "tags" {
  type = map(string)
  default = {
    Application        = "mayabank-platform"
    Environment        = "lab"
    Owner              = "architecture"
    CostCenter         = "training"
    Criticality        = "low"
    DataClassification = "internal"
    ManagedBy          = "terraform"
  }
}

resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

resource "azurerm_resource_group" "this" {
  name     = "rg-mbk-identity-lab"
  location = var.location
  tags     = var.tags
}

resource "azurerm_user_assigned_identity" "this" {
  name                = "id-mbk-lab"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  tags                = var.tags
}

resource "azurerm_key_vault" "this" {
  name                        = "kv-mbk-${random_string.suffix.result}"
  location                    = azurerm_resource_group.this.location
  resource_group_name         = azurerm_resource_group.this.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"
  enable_rbac_authorization   = true
  purge_protection_enabled    = false
  soft_delete_retention_days  = 7
  public_network_access_enabled = true
  tags                        = var.tags
}

resource "azurerm_role_assignment" "identity_secrets_user" {
  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.this.principal_id
}

output "key_vault_name" {
  value = azurerm_key_vault.this.name
}

output "managed_identity_principal_id" {
  value = azurerm_user_assigned_identity.this.principal_id
}
