#!/usr/bin/env bash

VERSION=v1.0.0
if [[ $# == 1 ]];then
    VERSION=$1
fi
if [ -z "${DOCKER_REPO}" ]; then
    DOCKER_REPO=ros-melodic
fi

IMG=${DOCKER_REPO}:$VERSION
#LOCAL_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../.." && pwd )"
LOCAL_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# if [ ! -e "${LOCAL_DIR}/data/log" ]; then
#     mkdir -p "${LOCAL_DIR}/data/log"
# fi
# if [ ! -e "${LOCAL_DIR}/data/bag" ]; then
#     mkdir -p "${LOCAL_DIR}/data/bag"
# fi
# if [ ! -e "${LOCAL_DIR}/data/core" ]; then
#     mkdir -p "${LOCAL_DIR}/data/core"
# fi

#source ${LOCAL_DIR}/scripts/apollo_base.sh

function find_device() {
    # ${1} = device pattern
    local device_list=$(find /dev -name "${1}")
    if [ -z "${device_list}" ]; then
        warning "Failed to find device with pattern \"${1}\" ..."
    else
        local devices=""
        for device in $(find /dev -name "${1}"); do
            ok "Found device: ${device}."
            devices="${devices} --device ${device}:${device}"
        done
        echo "${devices}"
    fi
}

function main(){
    #docker pull $IMG
    #docker stop apollo_dev
    #docker rm -f apollo_dev

    local display=""
    if [[ -z ${DISPLAY} ]];then
        display=":0"
    else
        display="${DISPLAY}"
    fi


    # setup CAN device
    sudo mknod --mode=a+rw /dev/can0 c 52 0
    # enable coredump
    #echo "${LOCAL_DIR}/data/core/core_%e.%p" | sudo tee /proc/sys/kernel/core_pattern


    local devices=""
    devices="${devices} $(find_device ttyUSB*)"
    devices="${devices} $(find_device ttyS*)"
    devices="${devices} $(find_device can*)"
    devices="${devices} $(find_device ram*)"
    devices="${devices} $(find_device loop*)"
    devices="${devices} $(find_device js0)"
    USER_ID=$(id -u)
    LOCAL_HOST=`hostname`
    docker run -it \
        -d \
        --name ros-melodic \
        -e DISPLAY=$display \
        -e DOCKER_USER=$USER \
        -e USER=$USER \
        -e DOCKER_USER_ID=$USER_ID \
        -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
        -v $LOCAL_DIR:/work \
        -v /media:/media \
        -v $HOME:/home/$USER \
        -v /etc/localtime:/etc/localtime:ro \
        --net host \
        -w /work \
        ${devices} \
        --add-host in_dev_docker:127.0.0.1 \
        --add-host ${LOCAL_HOST}:127.0.0.1 \
        --hostname in_dev_docker \
        --shm-size 512M \
        $IMG
    #docker exec apollo_dev bash -c '/apollo/scripts/docker_adduser.sh'
    #docker exec apollo_dev bash -c 'rm -rf /apollo/third_party/ros_*'
    #docker exec apollo_dev bash -c 'cp -Lr /root/ros_* /apollo/third_party/'
    docker exec apollo_dev bash -c "chown -R ${USER}:${USER} /apollo"
}

main
