#!/bin/bash

logger() {
    if [ $1 -ne 0 ]
    then
        echo " ..failed.. "
        exit 1
    fi
}

sudo yum install fontconfig java-17-openjdk -y

logger $?

sudo yum install yum-utils -y

logger $?

sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo

logger $?

sudo yum install terraform -y

logger $?

dnf module disable nodejs -y

logger $?

dnf module enable nodejs:18 -y

dnf install nodejs -y