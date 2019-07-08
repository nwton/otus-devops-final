terraform {
  # Версия terraform
  required_version = ">=0.11,<0.12"
}

provider "google" {
  # Версия провайдера
  version = "2.0.0"

  # ID проекта
  project = "${var.project}"

  region = "${var.region}"
}

module "gitlab" {
  source            = "../modules/gitlab"
  public_key_path   = "${var.public_key_path}"
  zone              = "${var.zone}"
  gitlab_disk_image = "${var.disk_image}"
  tf_env            = "${var.tf_env}"
}

module "vpc" {
  source        = "../modules/vpc"
  source_ranges = ["0.0.0.0/0"]
  tf_env        = "${var.tf_env}"
}
