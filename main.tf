resource "azurerm_app_configuration" "appconf" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_role_assignment" "appconf_dataowner" {
  scope                = azurerm_app_configuration.appconf.id
  role_definition_name = "App Configuration Data Owner"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_app_configuration_key" "key_values" {
  for_each               = var.key_values
  configuration_store_id = azurerm_app_configuration.appconf.id
  key                    = each.value.key
  label                  = each.value.label
  value                  = each.value.value

  depends_on = [
    azurerm_role_assignment.appconf_dataowner
  ]
}

resource "azurerm_app_configuration_key" "kv_reference" {
  for_each               = var.key_values_kv_reference
  configuration_store_id = azurerm_app_configuration.appconf.id
  key                    = each.value.key
  type                   = "vault"
  label                  = each.value.label
  vault_key_reference    = each.value.vault_key_reference

  depends_on = [
    azurerm_role_assignment.appconf_dataowner
  ]
}

resource "azurerm_app_configuration_feature" "feature_flags" {
  for_each               = var.feature_flags
  configuration_store_id = azurerm_app_configuration.appconf.id
  description            = each.value.description
  name                   = each.value.name
  label                  = each.value.label
  enabled                = each.value.enabled
}

