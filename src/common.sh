#!/usr/bin/env bash

shopt -s nocasematch

display() {
    printf "$1\n";
}

display_header() {
    if [ -t 1 ] # is stdout a terminal ?
    then
        printf "\e[30m\e[100m  \e[104m $1 \e[0m\n";
    else
        printf "### $1\n";
    fi
}

display_success() {
    if [ -t 1 ] # is stdout a terminal ?
    then
        printf "\e[92m$1\e[0m\n";
    else
        printf "$1\n";
    fi
}

display_info() {
    if [ -t 1 ] # is stdout a terminal ?
    then
        printf "\e[1;34m$1\e[0m\n";
    else
        printf "$1\n";
    fi
}

display_warning() {
    if [ -t 1 ] # is stdout a terminal ?
    then
        printf "\e[93m$1\e[0m\n" 1>&2
    else
        printf "$1\n" 1>&2
    fi
}

display_error() {
    if [ -t 1 ] # is stdout a terminal ?
    then
        printf "\e[101m$1\e[0m\n" 1>&2
    else
        printf "$1\n" 1>&2
    fi
}

display_step() {
    if [ -t 1 ] # is stdout a terminal ?
    then
        local MSG=$@
        echo ""
        printf "\e[90m \e[100m  \e[43m                                                        \e[0m"|head -c 80 ;echo ""
        printf "\e[30m \e[100m  \e[43m   $1                                                   "|head -c 75; printf "\e[0m\n"
        printf "\e[90m \e[100m  \e[43m                                                        \e[0m"|head -c 80 ; echo ""
        echo ""
    else
        printf "### $@\n";
    fi
}

check() {
    local LAST_ERROR=$?
    if [ ${LAST_ERROR} -ne 0 ]; then
        display_last_error "${LAST_ERROR}" "${1}"
        exit ${LAST_ERROR}
    fi
}

check_silently() {
    local LAST_ERROR=$?
    if [ ${LAST_ERROR} -ne 0 ]; then
        display_last_error "${LAST_ERROR}" "${1}"
    fi
}

display_last_error() {
    display_error "Error in last command"
    display_error "Return code was ${1}"
}

get_hosts_path() {
    if [ "${DEEZER_HOST_PLATFORM}" = "NT" ];then
        echo '/mnt/c/Windows/System32/drivers/etc/hosts'
    else
        echo '/etc/hosts'
    fi
}

has_oh_my_zsh() {
    if [ -n "${ZSH}" ] && [ -f "${ZSH}/oh-my-zsh.sh" ]; then
        echo "true"
    else
        echo "false"
    fi
}

get_octal_permissions() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    echo $(stat -f %A $1)
  else
    echo $(stat -c %a $1)
  fi
}

sanitize_path() {
    echo "${1/#\~/$HOME}"
}
