variable zone {
  description = "Zone for instances"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable gitlab_disk_image {
  description = "Disk image for reddit app"
  default     = "docker-base"
}

variable tf_env {
  description = "Environment"
  default     = "unknown"
}
