// Enabling APIs for the service to run
resource "google_project_service" "project_services" {
  for_each                   = toset(var.activate_apis)
  project                    = var.project
  service                    = each.value
  disable_on_destroy         = false
  disable_dependent_services = false
}

// Notifications to Email
resource "google_monitoring_notification_channel" "email_notifications" {
  for_each     = toset(var.email_addresses)
  display_name = each.value
  project      = var.project
  type         = "email"
  labels = {
    email_address = each.value
  }
}

// Notifications to Slack
resource "google_monitoring_notification_channel" "slack_notifications" {
  type         = "slack"
  display_name = "#tfe_support_channel"
  project      = var.project
  labels = {
    auth_token   = var.slack-auth-token
    channel_name = "#terraform-enterprise-deployment"
  }
}

// Notifications to Pagerduty
// To ADD


//Alerting Policies Configuration : CPU Utilization
resource "google_monitoring_alert_policy" "cpu_alert_policy" {
  display_name = "high-CPU-utilization"
  combiner     = "OR"
  conditions {
    display_name = "instance/high-CPU-utilization"
    condition_threshold {
      filter     = "metric.type=\"compute.googleapis.com/instance/cpu/utilization\" resource.type=\"gce_instance\""
      duration   = "60s"
      comparison = "COMPARISON_GT"
      threshold_value = 0.5
      trigger {
          count = 1
      }
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_SUM"
        cross_series_reducer = "REDUCE_MAX"
      }
    }
  }
  enabled = true
  // notification_channels = values(google_monitoring_notification_channel.email_notifications)[*].name
  notification_channels = [google_monitoring_notification_channel.slack_notifications.name]

  depends_on = [
    google_monitoring_notification_channel.slack_notifications,
  ]

  documentation {
    content = <<EOF

**Hello**

It appears the **Terraform Enterprise Instance** is running **High** on **CPU**
- **SSH** into the *instance*,  type `top` command, and press Enter
- By default, all processes are sorted according to their CPU utilization with the high value at the top
- Based on the process, necessary steps can be taken.

**Team Terraform**
EOF
  }
}
