resource "google_compute_instance" "gitlab" {
  name         = "gitlab-${var.tf_env}"
  machine_type = "n1-standard-1"
  zone         = "${var.zone}"
  tags         = ["gitlab"]

  # определение загрузочного диска
  boot_disk {
    initialize_params {
      size  = 50
      image = "${var.gitlab_disk_image}"
    }
  }

  metadata {
    # путь до публичного ключа
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }

  # определение сетевого интерфейса
  network_interface {
    # сеть, к которой присоединить данный интерфейс
    network = "default"

    # использовать statical IP для доступа из Интернет
    access_config = {
      nat_ip = "${google_compute_address.gitlab_ip.address}"
    }
  }
}

resource "google_compute_address" "gitlab_ip" {
  name = "gitlab-ip"
}

resource "google_compute_firewall" "firewall_gitlab" {
  name    = "web-access-gitlab-${var.tf_env}"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["gitlab"]
}
