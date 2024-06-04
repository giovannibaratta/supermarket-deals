variable "primary_region" {
  default = "us-east-1"
  type = string
  description = "AWS primary region"
}

variable "tags" {
  description = "Tags to apply at the provider level"
  type = map(string)
  default = {}
}