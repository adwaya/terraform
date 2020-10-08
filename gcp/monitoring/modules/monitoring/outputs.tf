output "email_notifications" {
  description = "Email Notification Channel"
  value       = values(google_monitoring_notification_channel.email_notifications)[*].name
}
