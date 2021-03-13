#!/bin/bash
# shellcheck disable=SC1091
source /srv/init-env.sh
source /srv/utils.sh

echo "c> Creating Log files..."
touch "${LOG_PATH}"/{server-raw,server,output,error,backup,restore,health,exit}.log
chmod 664 "${LOG_PATH}/"*

function vhpretty {
  /srv/vhpretty.py
}

function output-log {
  echo "${LOG_PATH}/output.log"
}

function tee-output {
   tee "$(output-log)"
}

function tee-server-raw {
  tee "${LOG_PATH}/server-raw.log"
}

function server-log {
  echo "${LOG_PATH}/server.log"
}

function tee-server {
  tee "$(server-log)"
}

function tee-backup {
   tee "${LOG_PATH}/backup.log" | tee-output
}

function tee-exit {
  tee "${LOG_PATH}/exit.log" | tee-output
}

function log {
  log-stdout "${*}" | tee-output
}

function log-env {
  for VAR in "$@"
  do
      debug-log "$VAR: ${!VAR:-(empty)}"
  done
}

function debug-log {
  echo "d> ${*}" | tee-output
}

