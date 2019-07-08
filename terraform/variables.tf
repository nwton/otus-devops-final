variable project {
  description = "Project ID"
}

variable gcs_bucket_name {
  description = "Google Cloud storage bucket name for tfstate"
}

variable region {
  # Описание переменной
  description = "Region"

  # Значение по умолчанию
  default = "europe-west1"
}
