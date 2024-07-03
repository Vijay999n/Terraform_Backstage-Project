resource "aws_instance" "my_instance" {

  count = length(var.ec2_names)
  ami           = var.ec2_ami
  instance_type = var.ec2_instance_type

  subnet_id     = var.private_subnet_id

  vpc_security_group_ids = [var.sg_id]

  

  user_data = <<-EOF
            #!/bin/bash
            # Update and install dependencies
            yum update -y
            amazon-linux-extras install -y docker
            service docker start
            usermod -a -G docker ec2-user

            # Install Kubernetes tools
            curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
            chmod +x ./kubectl
            mv ./kubectl /usr/local/bin/kubectl

            curl -LO "https://github.com/kubernetes/kubernetes/releases/download/v1.21.0/kubernetes-server-linux-amd64.tar.gz"
            tar -xzvf kubernetes-server-linux-amd64.tar.gz

            # Install kubeadm and kubelet
            cat <<EOF1 > /etc/yum.repos.d/kubernetes.repo
            [kubernetes]
            name=Kubernetes
            baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
            enabled=1
            gpgcheck=1
            repo_gpgcheck=1
            gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
            EOF1

            yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
            systemctl enable kubelet && systemctl start kubelet

            # Initialize Kubernetes
            kubeadm init --pod-network-cidr=10.244.0.0/16

            # Set up local kubeconfig
            mkdir -p $HOME/.kube
            cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
            chown $(id -u):$(id -g) $HOME/.kube/config

            # Install a pod network add-on (flannel)
            kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
            EOF
tags = {
    Name = var.ec2_names[count.index]
  }

}

