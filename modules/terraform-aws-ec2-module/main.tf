resource "aws_instance" "instance" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  associate_public_ip_address = var.associate_public_ip
  availability_zone           = var.availability_zone
  key_name                    = var.key
  vpc_security_group_ids      = var.security_group_ids
  subnet_id                   = var.subnet_id        
  user_data                   = var.user_data
  iam_instance_profile = var.instance_profile

provisioner "file" {
        source      = "../ansible/ansible_negix.yml"
        destination = "/home/ec2-user/ansible_negix.yml"
      }

provisioner "file" {
        source      = "../ansible/template.j2"
        destination = "/home/ec2-user/template.j2"
      }

provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras install ansible2 -y",
      "ansible-playbook ansible_negix.yml --extra-vars 'server_name=${var.user_data}'",
    ]
}
  connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ec2-user"
      private_key = file("./dev-ops.pem")
      timeout     = "4m"
      agent = false
   }

    tags = {
    name = var.instance_name
    }
}

resource "aws_lb_target_group_attachment" "tg_attachment_test" {
    target_group_arn = var.target_group
    target_id        = aws_instance.instance.id
    port             = 80
}