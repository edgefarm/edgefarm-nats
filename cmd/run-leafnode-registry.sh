#!/bin/bash

run_leafnode_registry() {
    /registry --natsuri nats://localhost:4222 --state /state/state.json &
}