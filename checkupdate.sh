#!/usr/bin/env bash

newest_ver=$(hr cmd get_latest_version hansonrobotics/hrtool)
curr_ver=$(dpkg-query -W -f='${Version}\n' head-hr)
if dpkg --compare-versions $curr_ver lt ${newest_ver#v}; then
    if zenity --question --title "New Version Available" --text="Newer version of head-hr ($newest_ver) is available. Do you want to update?"; then
        echo "Update head-hr from \"${curr_ver}\" to \"${newest_ver#v}\""
        hr install head-hr
    fi
else
    echo "No update for head-hr available"
    newest_ext_ver=$(hr cmd get_latest_version hansonrobotics/hrtool-ext)
    curr_ext_ver=$(dpkg-query -W -f='${Version}\n' head-hr-ext)
    if dpkg --compare-versions $curr_ext_ver lt ${newest_ext_ver#v}; then
        if zenity --question --title "New Version Available" --text="Newer version of head-hr-ext ($newest_ext_ver) is available. Do you want to update?"; then
            echo "Update head-hr-ext from \"${curr_ext_ver}\" to \"${newest_ext_ver#v}\""
            hr install head-hr-ext
        fi
    else
        echo "No update for head-hr-ext available"
    fi
fi
