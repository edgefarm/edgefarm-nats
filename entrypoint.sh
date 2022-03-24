#!/bin/bash

source '/cmd/run-nats.sh'
source '/cmd/run-leafnode-registry.sh'
source '/cmd/monitor.sh'

run_leafnode_registry &
run_nats &
run_monitor
