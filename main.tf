terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.32.0"
    }
  }
}

provider "azurerm" {
  features {
  }
  # Configuration options
}

locals {
  count = "${length(split("/","${var.resource_id}"))-1}"
  diagnostic_name = "${split("/","${var.resource_id}")["${local.count}"]}"
  tags = {
    owner = "chenshu"
    usage = "terraform_sample"
  }
}

resource "azurerm_dashboard" "my-board" {
  name                = var.dashboard_name
  resource_group_name = var.rg_name
  location            = var.rg_location
  tags                = local.tags 
  dashboard_properties = <<DASH
{
    "lenses": {
      "0": {
        "order": 0,
        "parts": {
          "0": {
            "position": {
              "x": 0,
              "y": 0,
              "colSpan": 6,
              "rowSpan": 4
            },
            "metadata": {
              "inputs": [
                {
                  "name": "resourceTypeMode",
                  "isOptional": true
                },
                {
                  "name": "ComponentId",
                  "isOptional": true
                },
                {
                  "name": "Scope",
                  "value": {
                    "resourceIds": [
                      "/subscriptions/c022430e-7e85-46f0-898b-57c4edf3acc5/resourcegroups/psr-demo/providers/microsoft.operationalinsights/workspaces/loganalytics-psrdemo"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "132d357a-2f58-4ca6-a357-89c56442c41f",
                  "isOptional": true
                },
                {
                  "name": "Version",
                  "value": "2.0",
                  "isOptional": true
                },
                {
                  "name": "TimeRange",
                  "value": "P7D",
                  "isOptional": true
                },
                {
                  "name": "DashboardId",
                  "isOptional": true
                },
                {
                  "name": "DraftRequestParameters",
                  "isOptional": true
                },
                {
                  "name": "Query",
                  "value": "SparkLoggingEvent_CL\n| where Message contains \"Streaming query made progress\"\n| extend streaming_progress=parse_json(replace_string(Message, \"Streaming query made progress: \", \"\"))\n| extend timestamp = streaming_progress.timestamp\n| extend id = streaming_progress.id\n| extend runId = streaming_progress.runId\n| extend batchId = streaming_progress.batchId\n| extend tableName = streaming_progress.name\n| extend numInputRows = streaming_progress.numInputRows\n| extend inputRowsPerSecond = streaming_progress.inputRowsPerSecond\n| extend processedRowsPerSecond = streaming_progress.processedRowsPerSecond\n| extend durationMs_latestOffset = streaming_progress.durationMs.latestOffset\n| extend durationMs_triggerExecution = streaming_progress.durationMs.triggerExecution\n| extend sink_description = streaming_progress.sink.description\n| extend sink_dnumOutputRows = streaming_progress.sink.numOutputRows\n| where numInputRows > 0\n| project timestamp, tableName, numInputRows, inputRowsPerSecond,processedRowsPerSecond, id, runId, batchId,durationMs_latestOffset, durationMs_triggerExecution, sink_description, sink_dnumOutputRows, streaming_progress\n"
                },
                {
                  "name": "ControlType",
                  "value": "AnalyticsGrid",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "isOptional": true
                },
                {
                  "name": "PartTitle",
                  "value": "Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "loganalytics-psrdemo",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "isOptional": true
                },
                {
                  "name": "LegendOptions",
                  "isOptional": true
                },
                {
                  "name": "IsQueryContainTimeRange",
                  "value": false,
                  "isOptional": true
                }
              ],
              "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
              "settings": {
                "content": {
                  "PartTitle": "Streaming throught"
                }
              }
            }
          }
        }
      }
    },
    "metadata": {
      "model": {
        "timeRange": {
          "value": {
            "relative": {
              "duration": 24,
              "timeUnit": 1
            }
          },
          "type": "MsPortalFx.Composition.Configuration.ValueTypes.TimeRange"
        },
        "filterLocale": {
          "value": "en-us"
        },
        "filters": {
          "value": {
            "MsPortalFx_TimeRange": {
              "model": {
                "format": "utc",
                "granularity": "auto",
                "relative": "24h"
              },
              "displayCache": {
                "name": "UTC Time",
                "value": "Past 24 hours"
              },
              "filteredPartIds": [
                "StartboardPart-LogsDashboardPart-be6c3ae6-0e9d-4e65-860f-aac8ac0f627e"
              ]
            }
          }
        }
      }
    }
  }
DASH
}