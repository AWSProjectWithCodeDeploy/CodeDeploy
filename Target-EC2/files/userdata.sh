#!/bin/bash

# 시스템 패키지 업데이트 및 필수 도구 설치
sudo apt update -y
sudo apt-get install ca-certificates curl gnupg lsb-release -y
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin docker-compose git ruby wget unzip

# Java 설치
sudo apt install -y openjdk-17-jdk

# JAVA_HOME 설정
echo 'export JAVA_HOME="/usr/lib/jvm/java-1.17.0-openjdk-amd64"' >> /home/ubuntu/.bashrc
echo 'export PATH=$PATH:$JAVA_HOME/bin' >> /home/ubuntu/.bashrc
source /home/ubuntu/.bashrc

# CodeDeploy Agent 설치
cd /home/ubuntu
wget https://aws-codedeploy-ap-northeast-2.s3.amazonaws.com/latest/install -O install
sudo chmod +x ./install
sudo ./install auto
sudo rm -f ./install

# CodeDeploy Agent 서비스 등록 및 실행
sudo systemctl enable codedeploy-agent
sudo systemctl start codedeploy-agent

# 설치 성공 여부 확인 (디버깅용 로그)
echo "==== CodeDeploy Agent 상태 ===="
sudo systemctl status codedeploy-agent || sudo service codedeploy-agent status

# Docker 권한 설정 및 실행
sudo usermod -aG docker ubuntu
sudo systemctl enable docker
sudo systemctl start docker
