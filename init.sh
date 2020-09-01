#!/usr/bin/env bash

set -e  # 有错误就退出

## 设定 阿里dns
echo "nameserver 223.5.5.5"    >   /etc/resolv.conf  
echo "nameserver 8.8.8.8"    >>  /etc/resolv.conf

# 跟换阿里源
grep "archive.ubuntu.com" /etc/apt/sources.list && \
sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/' /etc/apt/sources.list 
apt-get update
apt-get update && apt-get install -y gnupg2


#  添加 科大ROS源
sh -c '. /etc/lsb-release && echo "deb http://mirrors.ustc.edu.cn/ros/ubuntu/ $DISTRIB_CODENAME main" > /etc/apt/sources.list.d/ros-latest.list'
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F42ED6FBAB17C654
apt-get update
#  
#  ######## pip
#  mkdir ${HOME}/.pip
#  tee ${HOME}/.pip/pip.conf <<-'EOF'
#  [global]
#  index-url = https://mirrors.aliyun.com/pypi/simple/
#  
#  #(legacy|columns)
#  format = columns
#  
#  [install]
#  trusted-host=mirrors.aliyun.com
#  EOF