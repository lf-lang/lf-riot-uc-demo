#!/usr/bin/env bash
set -e

run_with_timeout() {
    local duration=$1
    shift
    local command="$@"

    # Run the command with the specified timeout
    timeout "$duration" $command

    # Check the exit status of the timeout command
    if [ $? -eq 124 ]; then
        echo "Command timed out (success)."
        return 0
    elif [ $? -eq 0 ]; then
        echo "Command completed successfully within $duration."
        return 0
    else
        echo "Command failed."
        return 1
    fi
}

make all LF_MAIN=HelloWorld BOARD=native
run_with_timeout 10s make term
