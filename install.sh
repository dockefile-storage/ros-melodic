#!/usr/bin/env bash

set -e  # 有错误就退出

## 设定 阿里dns
echo "nameserver 223.5.5.5"    >   /etc/resolv.conf  
echo "nameserver 223.6.6.6"    >>  /etc/resolv.conf


tee /etc/resolv.conf <<-'EOF'
nameserver 114.114.114.114
nameserver 8.8.8.8
EOF


# 跟换阿里源
grep "archive.ubuntu.com" /etc/apt/sources.list && \
sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/' /etc/apt/sources.list && \

#  添加 科大ROS源
sh -c '. /etc/lsb-release && echo "deb http://mirrors.ustc.edu.cn/ros/ubuntu/ $DISTRIB_CODENAME main" > /etc/apt/sources.list.d/ros-latest.list'
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F42ED6FBAB17C654
apt-get update

apt-get install -y  \
	    python-dev \
        python-pip \
	    python3-dev \
        python3-pip \
        make \
        g++ \
        git 


apt install libc6:i386 --yes --allow-unauthenticated
apt-get install ros-melodic-desktop-full --yes --allow-unauthenticated
apt-get install ros-melodic-desktop-full --yes --allow-unauthenticated --fix-missing

apt-get install ros-melodic-rosbash ros-melodic-rosbash-params --yes --allow-unauthenticated 
apt-get install python-rosdep

tee ${HOME}/.bash_aliases <<-'EOF'
##################################
#  CUDA
##################################
source /opt/ros/melodic/setup.bash
EOF
source /opt/ros/melodic/setup.bash

##############
tee /etc/resolv.conf <<-'EOF'
nameserver 8.8.8.8
nameserver 114.114.114.114
EOF

rosdep init
rosdep update


#apt-get install libarmadillo-dev libglew-dev libssh2-1-dev python-flask python-requests wget --yes --allow-unauthenticated

######## pip
mkdir ${HOME}/.pip
tee ${HOME}/.pip/pip.conf <<-'EOF'
[global]
index-url = https://mirrors.aliyun.com/pypi/simple/

#(legacy|columns)
format = columns

[install]
trusted-host=mirrors.aliyun.com
EOF

#######

apt-get install vim --yes --allow-unauthenticated


