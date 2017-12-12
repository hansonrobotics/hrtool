#!/usr/bin/bash

newest_ver=$(hr cmd get_latest_version hansonrobotics/hrtool)
curr_ver=$(dpkg-query -W -f='${Version}\n' head-hr)
if dpkg --compare-versions $curr_ver lt ${newest_ver#v}; then
    zenity --title "New version" --info \
        --text="There is head-hr available. Run \"hr install head-hr\" to upgrade it"
else
    newest_ext_ver=$(hr cmd get_latest_version hansonrobotics/hrtool-ext)
    curr_ext_ver=$(dpkg-query -W -f='${Version}\n' head-hr-ext)
    if dpkg --compare-versions $curr_ext_ver lt ${newest_ext_ver#v}; then
        zenity --title "New version" --info \
            --text="There is new head-hr-ext available. Run \"hr install head-hr-ext\" to upgrade it"
    fi
fi
