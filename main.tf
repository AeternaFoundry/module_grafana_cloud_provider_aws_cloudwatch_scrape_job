resource "grafana_cloud_provider_aws_cloudwatch_scrape_job" "cloud_provider_aws_cloudwatch_scrape_jobs" {
  for_each = var.cloud_provider_aws_cloudwatch_scrape_jobs

  aws_account_resource_id = each.value.aws_account_resource_id
  name                    = each.value.name
  stack_id                = each.value.stack_id
  enabled                 = each.value.enabled
  export_tags             = each.value.export_tags
  regions_subset_override = each.value.regions_subset_override
  static_labels           = each.value.static_labels

  dynamic "custom_namespace" {
    for_each = each.value.custom_namespace != null ? each.value.custom_namespace : []
    content {
      dynamic "metric" {
        for_each = custom_namespace.value.metric != null ? custom_namespace.value.metric : []
        content {
          name       = metric.value.name
          statistics = metric.value.statistics
        }
      }
      name                    = custom_namespace.value.name
      scrape_interval_seconds = custom_namespace.value.scrape_interval_seconds
    }
  }

  dynamic "service" {
    for_each = each.value.service != null ? each.value.service : []
    content {
      dynamic "enhanced_metric" {
        for_each = service.value.enhanced_metric != null ? service.value.enhanced_metric : []
        content {
          name = enhanced_metric.value.name
        }
      }
      dynamic "metric" {
        for_each = service.value.metric != null ? service.value.metric : []
        content {
          name       = metric.value.name
          statistics = metric.value.statistics
        }
      }
      name = service.value.name
      dynamic "resource_discovery_tag_filter" {
        for_each = service.value.resource_discovery_tag_filter != null ? service.value.resource_discovery_tag_filter : []
        content {
          key   = resource_discovery_tag_filter.value.key
          value = resource_discovery_tag_filter.value.value
        }
      }
      scrape_interval_seconds = service.value.scrape_interval_seconds
      tags_to_add_to_metrics  = service.value.tags_to_add_to_metrics
    }
  }
}

