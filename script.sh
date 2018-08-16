#!/bin/bash

rm -rf /etc/apt/sources.list.d/*
echo "deb http://ftp.ch.debian.org/debian/ jessie main" >> /etc/apt/sources.list &&
echo "deb-src http://ftp.ch.debian.org/debian/ jessie main" >> /etc/apt/sources.list &&
echo "deb http://security.debian.org/ jessie/updates main" >> /etc/apt/sources.list &&
echo "deb-src http://security.debian.org/ jessie/updates main" >> /etc/apt/sources.list &&
echo "deb http://ftp.ch.debian.org/debian/ jessie-updates main" >> /etc/apt/sources.list &&
echo "deb-src http://ftp.ch.debian.org/debian/ jessie-updates main" >> /etc/apt/sources.list &&

apt-get update &&
apt-get install nginx -y &&

/etc/init.d/nginx restart