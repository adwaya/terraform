// resource "google_compute_address" "public_ip" {
//   name         = "public-ip"
//   address_type = "EXTERNAL"
//   project      = var.project
//   region       = var.region
// }


resource "google_compute_instance" "k8s_master" {
  name         = "${var.namespace}-master"
  machine_type = var.instance_config.machine_type
  zone         = var.zone
  tags         = ["k8sm"]
  project      = var.project

  # Definition of the boot disk - the initial image
  boot_disk {
    initialize_params {
      image = var.instance_config.disk_image

    }
  }
  network_interface {
    network = "default"
    access_config {
      // nat_ip = google_compute_address.public_ip
    }
  }
}
