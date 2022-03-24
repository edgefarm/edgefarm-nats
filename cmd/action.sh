#!/bin/bash
source '/cmd/run-nats.sh'

action() {
    pid=$(pidof nats-server -s)
    echo "PID: $pid"
    kill -15 $pid
    run_nats
}