output "resource_group_name" {
  description = "Resource group hosting Terraform state."
  value       = azurerm_resource_group.tfstate.name
}

output "storage_account_name" {
  description = "Storage account hosting Terraform state."
  value       = azurerm_storage_account.tfstate.name
}

output "container_name" {
  description = "Blob container hosting Terraform state."
  value       = azurerm_storage_container.tfstate.name
}

output "backend_config_example" {
  description = "Backend values to inject into downstream Terraform roots."
  value = {
    resource_group_name  = azurerm_resource_group.tfstate.name
    storage_account_name = azurerm_storage_account.tfstate.name
    container_name       = azurerm_storage_container.tfstate.name
    use_azuread_auth     = true
  }
}
