terraform {
  required_providers {
    checkpoint = {
      source  = "CheckPointSW/checkpoint"
      version = "2.10.0"
    }
  }
}

provider "checkpoint" {
  # Configuration options
  auto_publish_batch_size = 10
}