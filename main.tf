terraform {

  required_version = ">= 1.3"

  required_providers {

    azurerm = {

      source  = "hashicorp/azurerm"

      version = "~> 3.0"

    }

  }

  # Remote backend for storing terraform.tfstate in Azure Storage

  backend "azurerm" {

    resource_group_name  = "tfstate-rg511"

    storage_account_name = "tfstatestorage511"

    container_name       = "terraform-state511"

    key                  = "jenkins-demo.tfstate"

  }

}

provider "azurerm" {

  features {}

  # Service Principal authentication (passed from Jenkins / CLI variables)

  subscription_id = var.subscription_id

  client_id       = var.client_id

  client_secret   = var.client_secret

  tenant_id       = var.tenant_id

}

# Resource Group

resource "azurerm_resource_group" "rg" {

  name     = "JenkinsTerraformRG"

  location = "East US"

}

# Virtual Network

resource "azurerm_virtual_network" "vnet" {

  name                = "JenkinsVNet"

  address_space       = ["10.10.0.0/16"]

  location            = azurerm_resource_group.rg.location

  resource_group_name = azurerm_resource_group.rg.name

}