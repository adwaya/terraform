provider "google" {
project  = "gcp-project-name"
}

module "monitoring" {
  project = "gcp-project-name"
  source  = "../modules/monitoring"

  email_addresses = [
    "someone@something.com",
    "someone@something.com"
  ]
}
