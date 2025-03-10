provider "aws" {
  region = "us-east-1"  # Change to your preferred region
}

resource "aws_instance" "web_server" {
  ami           = "ami-0e731c8a588258d0d"  # Amazon Linux 2023 (update as needed)
  instance_type = "t2.micro"
  key_name      = "your-key-pair"  # Replace with your AWS key pair name

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "nginx-web-server"
  }

  user_data = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y nginx
    systemctl start nginx
    systemctl enable nginx
    echo "<h1>Deployed with Jenkins!</h1>" > /var/www/html/index.html
  EOF
}

resource "aws_security_group" "web_sg" {
  name        = "web-server-sg"
  description = "Allow HTTP and SSH traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Consider restricting to your IP for production
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "web_server_public_ip" {
  value = aws_instance.web_server.public_ip
}
