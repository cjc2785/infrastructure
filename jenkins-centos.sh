#!/bin/bash
yum update -y 

yum install git -y

#Docker
yum -y install lvm2 device-mapper device-mapper-persistent-data device-mapper-event device-mapper-libs device-mapper-event-libs
yum -y install  wget
wget https://download.docker.com/linux/centos/docker-ce.repo -O /etc/yum.repos.d/docker-ce.repo
yum -y install docker-ce

#Jenkins
yum install java-1.8.0-openjdk-devel -y
curl --silent --location http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo | tee /etc/yum.repos.d/jenkins.repo
rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
yum install jenkins -y

#aws cli
yum install epel-release -y
yum install python-pip -y
pip install --upgrade awscli


systemctl start docker
systemctl enable docker

systemctl start jenkins
systemctl enable jenkins

#allow jenkins to access docker daemon socket
chmod 666 /var/run/docker.sock