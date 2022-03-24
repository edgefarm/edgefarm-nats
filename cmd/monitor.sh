#!/bin/bash

source '/cmd/action.sh'

run_monitor() {
    while true; do
        inotifywait -e modify /config
        sleep 1
        echo "Config file changed, restarting..."
        action
    done;
}