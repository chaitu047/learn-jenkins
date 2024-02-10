#!/bin/bash

logger() {
    if [ $1 -ne 0 ]
    then
        echo " ..failed.. "
        exit 1
    fi
}

sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo

logger $?

sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

logger $?

sudo yum install fontconfig java-17-openjdk -y

logger $?

sudo yum install jenkins -y

logger $?

sudo systemctl start jenkins

logger $?
