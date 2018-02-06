#!/usr/bin/env bash
#
# To enable the completions either:
#  - place this file in /etc/bash_completion.d
#  or
#  - copy this file to e.g. ~/.hr/hr-completion.sh and add the line
#    below to your .bashrc after bash completion features are loaded
#    . ~/.hr/hr-completion.sh

_hr() {
  local command cur prev words cword
  local hr_commands="init install uninstall build clean cmd env update run stop version role"

  if type -t _init_completion >/dev/null; then
    _init_completion || return
  else
    cur=${COMP_WORDS[COMP_CWORD]}
    words=( ${COMP_WORDS[@]} )
    cword=$COMP_CWORD
    prev=${COMP_WORDS[COMP_CWORD-1]}
  fi

  for (( i=1 ; i < ${cword} ; i++ )) ; do
    if [[ ${words[i]} == -* ]] ; then continue; fi
    if [[ ${hr_commands} == *${words[i]}* ]] ; then
      command=${words[i]}
    fi
  done

  local opts=$(hr cmd list_options ${command} 2> /dev/null)
  for (( i=2 ; i < ${cword} ; i++ )) ; do
  if [[ ${words[i]} != -* ]] ; then opts= ;fi
  done

  case ${command} in
    install|build|clean|update|cmd|role)
      local args=$(hr cmd list_components ${command} 2> /dev/null)
      COMPREPLY=($(compgen -W "${opts} ${args}" -- ${cur}))
      ;;
    uninstall)
      local args=$(hr cmd list_installed ${command} 2> /dev/null)
      COMPREPLY=($(compgen -W "${opts} ${args}" -- ${cur}))
      ;;
    run)
      if (( ${cword} == 2 )); then
        local args=$(hr cmd list_robots 2> /dev/null)
        COMPREPLY=($(compgen -W "${opts} ${args}" -- ${cur}))
      fi
      if (( ${cword} == 3 )); then
        local args=$(hr cmd list_bodies 2> /dev/null)
        COMPREPLY=($(compgen -W "${opts} ${args}" -- ${cur}))
      fi
      ;;
    *)
      if (( ${cword} >= 2 )); then
        COMPREPLY=()
      else
        COMPREPLY=($(compgen -W "${hr_commands}" -- ${cur}))
      fi
      ;;
  esac
}

complete -o dirnames -F _hr hr
