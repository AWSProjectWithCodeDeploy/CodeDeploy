#!/bin/bash
apt update -y
apt install -y docker.io docker-compose git
systemctl enable docker && systemctl start docker
mkdir -p /home/ubuntu/jenkins
cd /home/ubuntu/jenkins
cat > docker-compose.yml <<EOF
version: '3.7'
services:
  jenkins:
    image: jenkins/jenkins:lts
    container_name: jenkins
    user: root
    ports:
      - "8080:8080"
    volumes:
      - ./jenkins_home:/var/jenkins_home
      - /var/run/docker.sock:/var/run/docker.sock
EOF

sudo docker-compose up -d
