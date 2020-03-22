variable "service_principl_id" {
  type = "string"
  description = "The id of the azure service principal for the Kubernetes cluster."
}

variable "service_principl_secret" {
  type = "string"
  description = "The secret of the azure service principal for the Kubernetes cluster."
}