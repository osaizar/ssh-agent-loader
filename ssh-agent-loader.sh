#!/bin/bash

SSH_AGENT_FILE="$HOME/.ssh_agent"

SSH_KEYS=("$HOME/.ssh/id_rsa" "$HOME/.ssh/flex_ra/osaizar_id_rsa")

function new_ssh_agent {
    ssh-agent > $SSH_AGENT_FILE
    chmod 600 $SSH_AGENT_FILE
}

function load_ssh_agent {
    eval $(cat $SSH_AGENT_FILE | grep -v echo)
    export SSH_AUTH_SOCK
    export SSH_AGENT_PID
}

function test_ssh_agent {
    ssh-add -l > /dev/null
    agent_status=$?
}

if [[ -f $SSH_AGENT_FILE ]]; then
    load_ssh_agent
    test_ssh_agent
fi

if [[ ! -f $SSH_AGENT_FILE || $agent_status -eq 2 ]]; then
    new_ssh_agent
    load_ssh_agent
    test_ssh_agent
fi

if [[ $agent_status -eq 2 ]]; then
    echo "Could not load SSH Agent."
    exit 2
elif [[ $agent_status -eq 1 ]]; then
    echo "First start for agent $SSH_AGENT_PID"
    echo "Loading keys"
    for s in $SSH_KEYS; do
        ssh-add "$s"
    done
elif [[ $agent_status -eq 0 ]]; then
    echo "Agent $SSH_AGENT_PID loaded"
    echo "Current identities:"
    ssh-add -l
fi
