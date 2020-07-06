variable "vpc_cidr" {
  default = "10.10.0.0/16"
}

variable "web-amis" {
  type = map
  default = {
    us-east-1 = "ami-0e9089763828757e1"
    #us-east-2 = "ami-02b5d851009889090"
  }

}

variable "region" {
  default = "us-east-1"
}

variable "web-count" {
  default = "1"
}

variable "web-tags" {
  type = map
  default = {
    Name = "web-server-apache"
  }
}