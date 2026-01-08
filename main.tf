resource "azurerm_resource_group" "rg" {
  name     = "cicdtest"
  location = "westeurope"
}

resource "azurerm_service_plan" "appserviceplan" {
  name                = "webapp-asplan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_app_service" "app" {
  name                = "hello-cicd-app"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_service_plan.appserviceplan.id
  site_config {
    linux_fx_version = "NODE|24-lts"
  }
}
