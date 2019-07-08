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
