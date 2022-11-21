variable "rg_name" {
  description = "resource group name to put the dashboard"
  default     = "rg1"
}

variable "rg_location" {
  description = "resource location"
  default     = "West US"
}

variable "dashboard_name" {
  description = "the name of the dashboard"
  default = "Monitoring_Dashboard"
}

variable "input_rg_name" {
  description = "Log analytics workspace resource group name"
  type        = string
  default = "Log_analytics_workspace"
}

variable "resource_id" {
  description = "Log analytics workspace resource ID."
  type        = string
  default = "/subscriptions/xxxx/resourcegroups/psr-demo/providers/microsoft.operationalinsights/workspaces/loganalytics-psrdemo"
}