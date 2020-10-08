variable "project" {}

variable "email_addresses" {
  description = "Members Email addresses"
  type        = list(string)
}

variable "slack-auth-token" {
  default = ""
}

// Optional! if apis are already enabled!
variable "activate_apis" {
  description = "The list of apis to activate within the project"
  type        = list(string)
  default = [
    "monitoring.googleapis.com"
  ]
}
