provider "aws" {
  region = "eu-central-1"
  shared_credentials_file = "~/.aws/creds"
  profile                 = "personal"
}

# resource "aws_key_pair" "mykey" {
#   key_name   = "terraformtest"
#   #public_key = "ssh-rsa my-public-key"
#   public_key = file("~/.aws/key.pub")
# }

resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = "t2.micro"

  tags = {
    Name = "TerraformTest"
  }
}
resource "null_resource" "remote-exec" {

  provisioner "file" {
    source      = "script.sh"
    destination = "~/script.sh"
    connection {
      type        = "ssh"
      user        = var.ssh_user
      private_key = file("~/.aws/key.private")
      host        = aws_instance.web.public_ip
      timeout     = "1m"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x ~/script.sh",
      "sh ~/script.sh",
    ]
    connection {
      type        = "ssh"
      user        = var.ssh_user
      private_key = file("~/.aws/key.private")
      host        = aws_instance.web.public_ip
      timeout     = "1m"
    }
  }
}
