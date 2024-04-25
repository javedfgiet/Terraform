# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  subscription_id = "c236257f-1483-4eb8-a335-52d37d67b08e"
}

resource "azurerm_resource_group" "example" {
  name     = "example"
  location = "Central US"
}