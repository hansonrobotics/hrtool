#!/usr/bin/env bash

log() {
    printf "$(date +'%Y-%m-%d %H:%M:%S') ${1}\n"
}

export GITHUB_TOKEN=fdaa6c9ef8a0208f5722ed415d231d486c487741
log "Starting"
while true; do
    sleep 1
    ping -c 1 google.com>/dev/null || continue
    curr_ver=$(dpkg-query -W -f='${Version}\n' head-hr)
    newest_ver=$(hr cmd get_latest_version hansonrobotics/hrtool)
    if [[ -z $newest_ver ]]; then
        log "Can't find newest hrtool version"
        continue
    fi
    if dpkg --compare-versions $curr_ver lt ${newest_ver#v}; then
        if zenity --question --title "New Version Available" --text="Newer version of head-hr ($newest_ver) is available. Do you want to update?"; then
            log "Update head-hr from \"${curr_ver}\" to \"${newest_ver#v}\""
            hr install head-hr
        else
            log "Update failed. Sleep one day"
            sleep 86400
        fi
    else
        log "No update for head-hr available"
        curr_ext_ver=$(dpkg-query -W -f='${Version}\n' head-hr-ext)
        if [[ -z curr_ext_ver ]]; then
            log "hrtool-ext is not installed"
            continue
        fi
        newest_ext_ver=$(hr cmd get_latest_version hansonrobotics/hrtool-ext)
        if [[ -z $newest_ext_ver ]]; then
            log "Can't find newest hrtool-ext version"
            continue
        fi
        if dpkg --compare-versions $curr_ext_ver lt ${newest_ext_ver#v}; then
            if zenity --question --title "New Version Available" --text="Newer version of head-hr-ext ($newest_ext_ver) is available. Do you want to update?"; then
                log "Update head-hr-ext from \"${curr_ext_ver}\" to \"${newest_ext_ver#v}\""
                hr install head-hr-ext
            else
                log "Update failed. Sleep one day"
                sleep 86400
            fi
        else
            log "No update for head-hr-ext available"
        fi
    fi
    sleep 600
done