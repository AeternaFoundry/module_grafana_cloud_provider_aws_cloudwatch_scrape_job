variable "cloud_provider_aws_cloudwatch_scrape_jobs" {
  description = <<EOT
Map of cloud_provider_aws_cloudwatch_scrape_jobs, attributes below
Required:
    - aws_account_resource_id
    - name
    - stack_id
Optional:
    - enabled
    - export_tags
    - regions_subset_override
    - static_labels
    - custom_namespace (block):
        - metric (optional, block):
            - name (required)
            - statistics (required)
        - name (required)
        - scrape_interval_seconds (optional)
    - service (block):
        - enhanced_metric (optional, block):
            - name (required)
        - metric (optional, block):
            - name (required)
            - statistics (required)
        - name (required)
        - resource_discovery_tag_filter (optional, block):
            - key (required)
            - value (required)
        - scrape_interval_seconds (optional)
        - tags_to_add_to_metrics (optional)
EOT

  type = map(object({
    aws_account_resource_id = string
    name                    = string
    stack_id                = string
    enabled                 = optional(bool)
    export_tags             = optional(bool)
    regions_subset_override = optional(set(string))
    static_labels           = optional(map(string))
    custom_namespace = optional(list(object({
      metric = optional(list(object({
        name       = string
        statistics = set(string)
      })))
      name                    = string
      scrape_interval_seconds = optional(number)
    })))
    service = optional(list(object({
      enhanced_metric = optional(list(object({
        name = string
      })))
      metric = optional(list(object({
        name       = string
        statistics = set(string)
      })))
      name = string
      resource_discovery_tag_filter = optional(list(object({
        key   = string
        value = string
      })))
      scrape_interval_seconds = optional(number)
      tags_to_add_to_metrics  = optional(set(string))
    })))
  }))
}

