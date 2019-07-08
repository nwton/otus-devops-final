resource "google_compute_firewall" "firewall_search_ui" {
  name = "web-access-se-ui-8000"

  description = "Allow access to web port 8000 for search engine UI"
  priority    = 1000

  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["8000"]
  }

  source_ranges = "${var.source_ranges}"
}
