data "aws_ami" "latest-amazon-linux-image" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_key_pair" "ssh-key" {
  key_name   = "var.keyname"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDQj1ZjYRzQnqYGLVNmA3fJ4b03ZcQ31MA+4h+HTajn8beofaDrSK5/UHRE6YIhGz4dw1GnfLQaRXrM4ejLQgeBO9ppSSQbNGX9Yw0MHRyZ8s3la5OYPJ3Qdalfe5/Qu8yhXNZUcu6tVwSIn5sAgWnJUkN8cMcwbpAUGHQHnmp7TN4CMbsL0JOv/hu6QQGbWRfClQ5R7fInIYGkpRuWOISi+k5LRqgj0vZTthSY+zyrBnviKc33ZkOFyNEY8WA4uQhwtZjzkjyzfuc+zqHIqpBhA1xmuZurCrI1Z54UlD8jpxgy4n8Y3Ic72j15wochd2TIpDLjqJCotC+dlAEGGuWgnPrEz3RuYFFwZ9m4SGYta5i4qlcSaSKhVmVOZZ9pqr/6r3VVNhBB5xVWPq2VPTt+KuqixiWsUE8t7qXhm+D1gGGcXWzI3Tz7o/hcCeM/lR8sMLMIPLI9p0HStISYJa8CUS9d2y99bOfXxjlULDueOhRj4/JwN8izfKGPY4UpkuU= fniba@DESKTOP-1LBE6HD"
}

resource "aws_instance" "myapp-server" {
  ami                         = data.aws_ami.latest-amazon-linux-image.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.ssh-key.key_name
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.default_security_group_id]
  availability_zone           = var.avail_zone
  associate_public_ip_address = true
  user_data                   = file("entry-script.sh")
  tags = {
    Name = "${var.env_prefix}-server"
  }
}
