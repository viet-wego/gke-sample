
variable "project_id" {
  description = "The project where we will deploy this"
}
variable "credentials" {
  description = "Path to JSON key file"
}

variable "region" {
  description = "(Optional) The region where we will deploy this"
  default     = "asia-southeast1"
}

variable "vpc_name" {
  description = "(Optional) The name of our VPC"
  default     = "gke-sample"
}
