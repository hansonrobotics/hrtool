#!/usr/bin/env bash

OS_VERSION=$(lsb_release --codename --short)
if [[ $OS_VERSION == 'trusty' ]]; then
    version=v0.9.0
elif [[ $OS_VERSION == 'xenial' || $OS_VERSION == 'bionic' ]]; then
    # Should choose version greater than v0.9.0
    version=$(curl https://github.com/hansonrobotics/hrtool/releases/latest | sed 's#^.*<a href=".*/\(.*\)">.*</a>.*#\1#')
    pkg_ver=${version##v}
    if dpkg --compare-versions $pkg_ver le "0.9.0"; then
        echo "The OS version is not supported yet"
        exit
    fi
fi

SUDO=""
if [[ $(id -u) != 0 ]]; then
    SUDO="sudo"
fi
curl -sLo /tmp/head-hr_${version}_amd64.deb https://github.com/hansonrobotics/hrtool/releases/download/${version}/head-hr_${version#v}_amd64.deb
if [[ -f /usr/local/bin/hr-base ]]; then
    $SUDO rm /usr/local/bin/hr
    $SUDO rm /usr/local/bin/hr-base
    $SUDO rm /usr/local/bin/hr-ext
fi
$SUDO dpkg -i /tmp/head-hr_${version}_amd64.deb || $SUDO apt-get install -yf
rm /tmp/head-hr_${version}_amd64.deb
