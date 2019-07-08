variable project {
  description = "Project ID"
}

variable tf_state_bucket {
  description = "Google Cloud Storage bucket name for tfstate"
}

variable region {
  # Описание переменной
  description = "Region"

  # Значение по умолчанию
  default = "europe-west1"
}

variable zone {
  description = "Zone for instances"
  default     = "europe-west1-b"
}

variable tf_env {
  description = "Environment"
  default     = "unknown"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable private_key_path {
  description = "Path to the PRIVATE key used for ssh access"
}

variable disk_image {
  description = "Disk image"
}
