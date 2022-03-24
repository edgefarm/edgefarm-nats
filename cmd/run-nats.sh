#!/bin/bash

run_nats() {
    /nats-server -js -c /config/nats.json &
}