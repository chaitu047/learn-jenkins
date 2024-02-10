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