#!/usr/bin/env bash

#set -e  # 有错误就退出
tee ${HOME}/.bash_aliases <<-'EOF'
source /opt/ros/melodic/setup.bash
EOF
source /opt/ros/melodic/setup.bash

##############
tee /etc/resolv.conf <<-'EOF'
nameserver 8.8.8.8
nameserver 114.114.114.114
EOF

echo "nameserver 8.8.8.8"  > /etc/resolv.conf && \
echo "nameserver 114.114.114.114"  >> /etc/resolv.conf && \
source /opt/ros/melodic/setup.bash && rosdep init && \
source /opt/ros/melodic/setup.bash && rosdep update
