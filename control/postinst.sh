#!/usr/bin/env bash

if [[ ! -e /usr/bin/hr ]]; then
    ln -sf -T /opt/hansonrobotics/hrtool/hr-base /usr/bin/hr
    ln -sf -T /opt/hansonrobotics/hrtool/head.ld.conf /etc/ld.so.conf.d/head.ld.conf
fi
