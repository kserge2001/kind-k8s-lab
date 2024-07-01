resource "aws_security_group" "sg-demo" {
    name = "kind-sg"
    description = "Allow ssh and httpd"
    
    ingress {
        description = "allow ssh"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "allow http"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
 
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
  tags= {
    env = "Dev"
  }
  
}

resource "aws_instance" "server1" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.small"
  # security_groups = [aws_security_group.sg-demo.name]
  vpc_security_group_ids = [aws_security_group.sg-demo.id]
  key_name      = aws_key_pair.ec2_key.key_name
  user_data     = file("server.sh")
  tags ={
    Name = "kind-K8s-Server"
  }
  
}

/*
resource "null_resource" "n1" {
  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file(local_file.ssh_key.filename)
    host = aws_instance.server1.public_dns
  }
  
  provisioner "file" {
    source = "kind.yaml"
    destination = "/home/ubuntu/kind.yaml"
  }
  provisioner "remote-exec" {
    inline = [
        "sleep 360",
        "kind create cluster --name demo-cluster --config kind.yaml"
     ]
     
  }
  depends_on = [ local_file.ssh_key , aws_instance.server1]
}
*/