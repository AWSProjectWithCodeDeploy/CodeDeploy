#!/bin/bash
sudo apt update -y
sudo apt install -y openjdk-17-jdk git maven
git clone https://github.com/spring-projects/spring-petclinic.git
cd spring-petclinic
./mvnw spring-boot:run > /dev/null 2>&1 &
