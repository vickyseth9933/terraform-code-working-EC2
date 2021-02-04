#adding resource for aws
resource "aws_instance" "web" {
  #including count parameter, so here count is 2 , we can change it from var value
  count = var.web-count
  #here we have used map variable which is defined in var.tf
  #created 2 variable , one is var.web-amis and 2nd is var.region
  ami = var.web-amis[var.region]
  instance_type = "t2.micro"
  key_name = "todaydemo"
  ##userdata
  user_data = templatefile("${path.module}/templates/startup-script.tmpl", {
    myMessage = "terraform code run successfully with vpc, subnet, igw!",
  })
  #now to link with subnet and vpc we have created
  subnet_id = local.public_subnet[count.index]
  #from locals , in local we have used merge ( used to merge 2 variable or var+local togather
  tags = local.web_tags
}


locals {
  env_tags = {
    Environment = terraform.workspace
  }
  web_tags = merge(var.web-tags, local.env_tags)
}

output "instance_ip" {
  value = aws_instance.web.*.public_ip
}

output "instance_id" {
  value = aws_instance.web.*.id
}


