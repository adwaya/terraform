resource "google_compute_firewall" "allow-ports" {
  name        = "${var.namespace}-firewall"
  project      = var.project
  network     = var.network
  target_tags = ["k8sw"]

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "22"]
  }

  allow {
    protocol = "icmp"
  }
}
