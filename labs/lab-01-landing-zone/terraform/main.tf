resource "azurerm_resource_group" "platform_lab" {
  name     = "rg-mbk-platform-lab"
  location = var.location
  tags     = var.tags
}

resource "azurerm_policy_definition" "require_environment_tag" {
  name         = "mbk-require-environment-tag"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "MayaBank - Require Environment tag"
  description  = "Requires the Environment tag on taggable Azure resources."

  metadata = jsonencode({
    category = "MayaBank Governance"
    version  = "1.0.0"
  })

  policy_rule = jsonencode({
    if = {
      field  = "tags['Environment']"
      exists = "false"
    }
    then = {
      effect = "deny"
    }
  })
}

resource "azurerm_subscription_policy_assignment" "require_environment_tag" {
  name                 = "mbk-require-environment-tag"
  display_name         = "MayaBank - Require Environment tag"
  description          = "Baseline governance guardrail used by LAB 01."
  subscription_id      = data.azurerm_subscription.current.id
  policy_definition_id = azurerm_policy_definition.require_environment_tag.id
}

output "subscription_id" {
  value = data.azurerm_subscription.current.subscription_id
}

output "resource_group_name" {
  value = azurerm_resource_group.platform_lab.name
}

output "policy_definition_id" {
  value = azurerm_policy_definition.require_environment_tag.id
}

output "policy_assignment_id" {
  value = azurerm_subscription_policy_assignment.require_environment_tag.id
}
