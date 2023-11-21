#!/bin/bash
# Version 1.0
# Copyright (c) 2023 3nine
# Author: 3nine
# License: MIT
# https://github.com/3nine/pi/main/LICENSE.md

header_info() {
  clear
  cat <<"EOF"

  _    _   _                       _               _____                  _       _____                 _             _   _ 
 | |  | | | |                     | |             |  __ \                | |     |_   _|               | |           | | | |
 | |  | | | |__    _   _   _ __   | |_   _   _    | |__) |   ___    ___  | |_      | |    _ __    ___  | |_    __ _  | | | |
 | |  | | | '_ \  | | | | | '_ \  | __| | | | |   |  ___/   / _ \  / __| | __|     | |   | '_ \  / __| | __|  / _` | | | | |
 | |__| | | |_) | | |_| | | | | | | |_  | |_| |   | |      | (_) | \__ \ | |_     _| |_  | | | | \__ \ | |_  | (_| | | | | |
  \____/  |_.__/   \__,_| |_| |_|  \__|  \__,_|   |_|       \___/  |___/  \__|   |_____| |_| |_| |___/  \__|  \__,_| |_| |_|
                                                                                                                            
                                                                                                                            
EOF
}

RD=$(echo "\033[01;31m")
YW=$(echo "\033[33m")
GN=$(echo "\033[1;92m")
CL=$(echo "\033[m")
BFR="\\r\\033[K"
HOLD="-"
CM="${GN}✓${CL}"
CROSS="${RD}✗${CL}"

set -euo pipefail
shopt -s inherit_errexit nullglob

msg_info() {
  local msg="$1"
  echo -ne " ${HOLD} ${YW}${msg}..."
}

msg_ok() {
  local msg="$1"
  echo -e "${BFR} ${CM} ${GN}${msg}${CL}"
}

msg_error() {
  local msg="$1"
  echo -e "${BFR} ${CROSS} ${RD}${msg}${CL}"
}

start_routines() {

CHOICE=$(whiptail --backtitle "Proxmox VE Helper Scripts" --title "UPDATE" --menu "\nUpdate Proxmox VE now?" 11 58 2 \
    "yes" " " \
    "no" " " 3>&2 2>&1 1>&3)
  case $CHOICE in
    yes)
      msg_info "Updating Updated Ubuntu (Patience)"
      apt-get update &>/dev/null
      apt-get -y dist-upgrade &>/dev/null
      msg_ok "Updated Ubuntu"
      ;;
    no)
      msg_error "Selected no to Updating Proxmox VE"
      ;;
  esac
  
}

header_info
echo -e "\nThis script will Perform Post Install Routines.\n"
while true; do
  read -p "Start the Ubuntu Post Install Script (y/n)?" yn
  case $yn in
  [Yy]*) break ;;
  [Nn]*) clear; exit ;;
  *) echo "Please answer yes or no." ;;
  esac
done

start_routines
