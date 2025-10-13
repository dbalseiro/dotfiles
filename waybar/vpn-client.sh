#!/bin/bash

set -o pipefail

function usage() {
  cat <<- END_OF_HELP
    ./vpn-client.sh <subcommand>

    Subcommands:
      current-state     -- Name of the current connection or <none> if no connection

END_OF_HELP
}

function errxit() {
  echo $*
  echo
  usage
  exit 1
}

function format-output() {
  read output
  echo ${output:-"<none>"}
}

function current-state() {
  isvpn='$3 == "vpn"'
  isconnected='$4 != ""'
  printname='print $1'

  nmcli -terse -color no con |
  awk -F: "$isvpn && $isconnected { $printname }" |
  head -1 |
  format-output
}

function connect-vpn() {
  nmcli con up juvo_2025
}

function disconnect-vpn() {
  nmcli con down $1
}

function send-message() {
  echo $(current-state)
}

function start() {
  send-message && start-server
}

function conn() {
  curconn=`current-state`
  case $curconn in
    "<none>") connect-vpn ;;
    *) disconnect-vpn $curconn ;;
  esac
  send-message
}

case $1 in
  "") errxit "MISSING COMMAND" ;;
  conn|start|current-state) $1 ;;
  *) errxit "INVALID COMMAND: $1" ;;
esac

