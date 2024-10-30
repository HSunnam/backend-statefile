#-------------------------------------------
# variables.tf
# - variables used in terraform module
#--------------------------------------------

variable "tags" {
  description = "Common set of tags."
  type        = map(string)
  default     = {}
}
