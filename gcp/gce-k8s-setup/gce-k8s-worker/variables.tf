
variable "project" {
  description = "Project ID"
  default     = {}
}
variable "region" {
  description = "Region"
  default     = "us-central1"
}

variable "network" {
  default = "default"
}
variable "zone" {
  description = "Zone"
  default     = "us-central1-a"
}


variable "instance_config" {
    type = object({
    machine_type   = string
    image_family   = string
    image_project  = string
    disk_image     = string
    boot_disk_size = number
    type           = string
  })
  default = {
    machine_type   = "n1-standard-4"
    image_family   = "ubuntu-1804-lts"
    image_project  = "ubuntu-os-cloud"
    disk_image     = "ubuntu-1804-bionic-v20200908"
    boot_disk_size = 20
    type           = "pd-standard"
  }
}

variable "namespace" {
  description = "The name to prefix to resources to keep them unique."
  default = "k8sw"
//   labels = {
//       owner = "you"
//       iac   = "terraform"
//       }
}

// variable "public_access" {
//   type        = bool
//   description = "If the instance should have a public IP."
//   default     = true
// }
