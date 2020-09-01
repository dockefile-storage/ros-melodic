#!/usr/bin/env bash

set -e  # 有错误就退出

# ## 设定 阿里dns
# echo "nameserver 223.5.5.5"    >   /etc/resolv.conf  
# echo "nameserver 8.8.8.8"    >>  /etc/resolv.conf
# 
# # 跟换阿里源
# grep "archive.ubuntu.com" /etc/apt/sources.list && \
# sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/' /etc/apt/sources.list 

apt-get update
apt-get update && apt-get install -y gnupg2

# #  添加 科大ROS源
# sh -c '. /etc/lsb-release && echo "deb http://mirrors.ustc.edu.cn/ros/ubuntu/ $DISTRIB_CODENAME main" > /etc/apt/sources.list.d/ros-latest.list'
# apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F42ED6FBAB17C654

sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

apt-get update
