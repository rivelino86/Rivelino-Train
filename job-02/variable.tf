variable "kind_of_server" {
  description = "which server do want to install/uninstall type 1 for jenkins or type 2 for splunk ?"
  
}

variable "ami" {
  default = "ami-0440d3b780d96b29d" # Amazon linux ami-0440d3b780d96b29d
}

variable "size" {
  default = "t2.medium"
}



