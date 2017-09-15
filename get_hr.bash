#!/usr/bin/env bash


version=$(curl https://github.com/hansonrobotics/hrtool/releases/latest | sed 's#^.*<a href=".*/\(.*\)">.*</a>.*#\1#')
curl -sLo /tmp/head-hr_${version}_amd64.deb https://github.com/hansonrobotics/hrtool/releases/download/${version}/head-hr_${version#v}_amd64.deb
if [[ -f /usr/local/bin/hr-base ]]; then
    sudo rm /usr/local/bin/hr
    sudo rm /usr/local/bin/hr-base
    sudo rm /usr/local/bin/hr-ext
fi
sudo dpkg -i /tmp/head-hr_${version}_amd64.deb || sudo apt-get install -yf
rm /tmp/head-hr_${version}_amd64.deb
