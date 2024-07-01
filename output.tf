output "ssh-command" {
  value = "ssh -i ${aws_key_pair.ec2_key.key_name}.pem ubuntu@${aws_instance.server1.public_ip}"
}

