resource "aws_instance" "jenkins" {
  # IMPORTANT: Replace ami-xxxxxxxxxxxxxxxxx with a valid AMI ID for ap-south-1 (Mumbai)
  # This AMI should be RedHat-based (e.g., Amazon Linux, CentOS, RHEL) for the Jenkins playbook.
  ami           = "ami-02dfbd4ff395f2a1b"
  instance_type = "t2.medium"
  key_name      = "awskey" # Ensure this key pair exists in your AWS account
  subnet_id     = aws_subnet.sub1_project.id # Place in sub1-project
  vpc_security_group_ids = [
    aws_security_group.jenkins_sg.id
  ]
  root_block_device {
    volume_size = 14 # GiB
  }
  user_data = local.jenkins_user_data # Apply user data only to Jenkins

  tags = {
    Name = "Jenkins"
  }
}

resource "aws_instance" "k8s_cp" {
  # IMPORTANT: Replace ami-xxxxxxxxxxxxxxxxx with a valid AMI ID for ap-south-1 (Mumbai)
  # This AMI should be Ubuntu-based for the Kubernetes playbook.
  ami           = "ami-0a640e53a0ceadca5"
  instance_type = "t2.medium"
  key_name      = "awskey" # Ensure this key pair exists in your AWS account
  subnet_id     = aws_subnet.sub2_project.id # Place in sub2-project
  vpc_security_group_ids = [
    aws_security_group.k8s_cp_sg.id
  ]
  root_block_device {
    volume_size = 20 # GiB
  }
  user_data = local.ubuntu_user_data # Apply user data for Ubuntu instances

  tags = {
    Name = "945-Project-CP"
  }
}

resource "aws_instance" "node1" {
  # IMPORTANT: Replace ami-xxxxxxxxxxxxxxxxx with a valid AMI ID for ap-south-1 (Mumbai)
  # This AMI should be Ubuntu-based for the Kubernetes playbook.
  ami           = "ami-0a640e53a0ceadca5"
  instance_type = "t2.medium"
  key_name      = "awskey" # Ensure this key pair exists in your AWS account
  subnet_id     = aws_subnet.sub3_project.id # Place in sub3-project
  vpc_security_group_ids = [
    aws_security_group.k8s_nodes_sg.id
  ]
  root_block_device {
    volume_size = 20 # GiB
  }
  user_data = local.ubuntu_user_data # Apply user data for Ubuntu instances

  tags = {
    Name = "Node1"
  }
}
