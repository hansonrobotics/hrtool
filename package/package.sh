#!/usr/bin/env bash
# Copyright (c) 2013-2018 Hanson Robotics, Ltd. 

package_ros_chatbot() {
    local reponame=hrtool

    mkdir -p $BASEDIR/src
    rsync -r --delete \
        --exclude ".git" \
        --exclude "package" \
        $BASEDIR/../ $BASEDIR/src/$reponame

    get_version $1

    local name=head-ros-env
    local desc="Hanson Robotics Software ROS Enviornment"
    local url="https://api.github.com/repos/hansonrobotics/$reponame/releases"

    fpm -C "${BASEDIR}" -s dir -t deb -n "${name}" -v "${version#v}" --vendor "${VENDOR}" \
        --url "${url}" --description "${desc}" ${ms} \
        --deb-no-default-config-files \
        -p $BASEDIR/${name}_VERSION_ARCH.deb \
        src/$reponame/rosenv/=${HR_ROS_PREFIX}/

    rm -r src
}

if [[ $(readlink -f ${BASH_SOURCE[0]}) == $(readlink -f $0) ]]; then
    BASEDIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))
    source $BASEDIR/common.sh
    source $BASEDIR/config.sh
    set -e

    package_ros_chatbot $1
fi
