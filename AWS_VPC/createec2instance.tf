#creat EC-2 instance 
resource "aws_instance" "my_instance" {
  ami           = "ami-024e6efaf93d85776"  # Replace with Ubuntu AMI ID
  instance_type = "t2.micro"
  #key_name = "deployer-key"
  subnet_id     = aws_subnet.levelup_vpc_public1.id
  vpc_security_group_ids = [aws_security_group.allow_levelup_ssh.id]

user_data = <<EOF
#!/bin/bash
echo "Copying the SSH Key to the server"
echo -e "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCyfTbQ5TOhb7iiPh6eeAlHWMdhs9gU+sEOGyD0Kh6h+nEoJsn2PrpN1W9PLtVotfKmy7OdaJPAXlwbqkh5ucE13F7FZw8ebt1juq26it4OvCIWvxCAeIPCv9pXOD8Zxd13d6hgvKG3/KwJ7d6InYqLZaQWRqLpnCvhRFSjiZhJZYYEzVkkStLSZia2TRgmv0O98yfo+9wkNwjBYGs7IDSJDFwT4IOskKL+XRcPYwqs4+GRLgejj961aAIdKuhxyS1XlPP6PVrpsXAK7mW8sSX4PN2zSntnApOT+IYLkkmmzoZKAjgSSdVY/4Vj3HJa3xIfLjNkX9iuGC5FpvPvizxz97ZnK8oiwUOCzsgdcIkOTf2Bx8DYx8JMYPubkk6eS6PA7SPFmc9KLjTvmmRg4AbeVB31P+BWIhLmZBkeEDLlk77tq9thWIxVT/0h3mXze5AV0yoNM0hqmUToGmO5EX3gDL9O7GcwF/W3Ve4SPl6NLvgmVVEYIZ5eQiTqn7audfDRMTn6DGlRIeca9NU6f4p93GKoMBym9Z7tbGuFA0xcZeIkaunEGtoFEo7ObLYeSMdaRqZBQ1gE5CDCzBv3BV0Z2de+1kP/4UPbu7iQvEyjehkGwA+k9fe7g718aGSVJ2ZFCcdU6eaoGjNjeCCUpiTVcODazBwwM0BQo7PX0Rg1lw== r.r.shete@gmail.com"
 EOF 
  
  // Add key_name for SSH access
  
  // Disable public IP assignment
  associate_public_ip_address = true
}
