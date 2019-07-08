variable source_ranges {
  description = "Allowed IP addresses"

  default = ["0.0.0.0/0"]
}

variable tf_env {
  description = "Environment"
  default     = "unknown"
}
