
resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "example" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "example" {
  name                = var.service_plan_name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  os_type             = "Linux"
  sku_name            = "Y1"
  reserved            = true
}

resource "azurerm_linux_function_app" "example" {
  name                       = var.function_app_name
  location                   = azurerm_resource_group.example.location
  resource_group_name        = azurerm_resource_group.example.name
  service_plan_id            = azurerm_service_plan.example.id
  storage_account_name       = azurerm_storage_account.example.name
  storage_account_access_key = azurerm_storage_account.example.primary_access_key
}

resource "azurerm_function_app_function" "example" {
  name            = var.function_name
  function_app_id = azurerm_linux_function_app.example.id
  app_settings    = {
    "AzureWebJobsStorage" = azurerm_storage_account.example.primary_connection_string
    "FUNCTIONS_WORKER_RUNTIME" = "node"
  }
  config_json = <<JSON
  {
    "bindings": [
      {
        "authLevel": "function",
        "type": "httpTrigger",
        "direction": "in",
        "name": "req"
      },
      {
        "type": "http",
        "direction": "out",
        "name": "$return"
      }
    ]
  }
  JSON
}
