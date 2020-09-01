# This is a comment
FROM ubuntu:18.04
MAINTAINER Jiangxumin <cjaingxumin@gmail.com>

USER    root
WORKDIR /root

# ENV TEST  123

COPY init.sh ./
#COPY install.sh ./
COPY ros_update.sh ./
COPY run.sh ./

RUN ./init.sh
#RUN ./install.sh

RUN apt-get install -y  \
	python-dev \
        python-pip \
	python3-dev \
        python3-pip \
	make \
        g++ \
        git \ 
        aptitude \
        iproute2 \
	can-utils

#############
# 时区
#############
RUN DEBIAN_FRONTEND=noninteractive apt install -y tzdata && \
	ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN dpkg-reconfigure -f noninteractive tzdata # 重新配置tzdata软件包，使得时区设置生效 

#############
# ros
#############
#RUN apt-get install ros-melodic-desktop-full --yes --allow-unauthenticated
RUN aptitude install ros-melodic-desktop-full -y -o APT::Get::Fix-Missing=true
#RUN apt-get install ros-melodic-desktop-full --yes --allow-unauthenticated --fix-missing

RUN apt-get install ros-melodic-rosbash ros-melodic-rosbash-params --yes --allow-unauthenticated 
RUN apt-get install -y python-catkin-pkg python-rosdep ros-melodic-catkin
RUN apt-get install -y python3-pip python3-colcon-common-extensions python3-setuptools python3-vcstool

RUN ./ros_update.sh

#apt-get install libarmadillo-dev libglew-dev libssh2-1-dev python-flask python-requests wget --yes --allow-unauthenticated
RUN apt-get install vim --yes --allow-unauthenticated


#VOLUME ["/data1","/data2"]
#EXPOSE 22
#EXPOSE 80
#EXPOSE 443
CMD ["/bin/bash","/root/run.sh"]
