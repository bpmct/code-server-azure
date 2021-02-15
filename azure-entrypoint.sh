#!/bin/bash

# Allow user to aupply a start dir, default to /home/coder/project
START_DIR=${1:-/home/coder/project}

# Clone the git repo, if was supplied
[[ -z "${GIT_REPO}" ]] && echo "\$GIT_REPO not specified" || git clone $GIT_REPO $START_DIR;


if [ "$DISABLE_SSH" != "true" ]; then
    # Start OpenSSH
    echo "Starting OpenSSH..."
    /usr/sbin/sshd &
fi

# Check if we should use --link (do not use link if $PASSWORD is supplied)
if [[ -z "${PASSWORD}" ]]; then
    # Run code-server with the default entrypoint and --link
    echo "\$PASSWORD not specified. Starting code-server --link..."
    /usr/bin/entrypoint.sh --link benapp $START_DIR 2>&1 | tee code-server-logs.txt &
    # Run a mini redirect server on port 80 to take the user to the --link URL (keeps Azure alive)
    sleep 5 && /home/coder/miniRedirectServer.py 80 2>&1 | tee redirect-logs.txt
else
    echo "Running code-server on :80 with \$PASSWORD..."
    # Run code-server on port 80
    /usr/bin/entrypoint.sh --bind-addr 0.0.0.0:80 $START_DIR 2>&1 | tee code-server-logs.txt
fi