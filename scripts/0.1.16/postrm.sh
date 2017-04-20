#!/usr/bin/env bash

fname=$(readlink -f /usr/bin/hr)
if [[ $fname == "/opt/hansonrobotics/hrtool/hr-base" ]]; then
    rm -f /usr/bin/hr
fi
