terraform {
  required_version = ">= 1.12, < 2.0"

  required_providers {
    alz = {
      source  = "azure/alz"
      version = "~> 0.21"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "~> 2.4"
    }
  }
}

data "azapi_client_config" "current" {}

provider "alz" {
  library_overwrite_enabled = true
  library_references = [
    {
      path = "platform/alz"
      ref  = "2026.04.2"
    }
  ]
}

module "alz" {
  source  = "Azure/avm-ptn-alz/azurerm"
  version = "0.21.0"

  architecture_name  = "alz"
  location           = var.location
  parent_resource_id = data.azapi_client_config.current.tenant_id
  enable_telemetry   = var.enable_telemetry
}
