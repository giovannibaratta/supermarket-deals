variable "primary_region" {
  type = string
  description = "AWS primary region"
}

variable "tags" {
  description = "Tags to apply at the provider level"
  type = map(string)
  default = {}
}