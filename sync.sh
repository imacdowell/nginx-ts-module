#!/bin/bash

# Usage: ./sync.sh [up|down]

LOCAL_DIR="."
REMOTE_DIR="imacdowell@192.168.1.183:./nginx-ts-module/"

# Rsync options
#RSYNC_OPTS="-avz --update --exclude='.git'"

usage() {
    echo "Usage: $0 [up|down]"
    exit 1
}

# Check if parameter is provided
if [ $# -eq 0 ]; then
    echo "Error: No direction specified"
    usage
fi

# Check if rsync is available
if ! command -v rsync &> /dev/null; then
    echo "Error: rsync is not installed"
    echo "Install with: brew install rsync"
    exit 1
fi

# Process the direction parameter
case "$1" in
    "up")
        echo "rsync: $LOCAL_DIR To: $REMOTE_DIR"
        rsync -avz --update --exclude='.git' "$LOCAL_DIR" "$REMOTE_DIR"
        ;;
    "down")
        echo "rsync: $REMOTE_DIR To: $LOCAL_DIR"
        rsync -avz --update --exclude='.git' "$REMOTE_DIR" "$LOCAL_DIR"
        ;;
    *)
        echo "Error: Invalid parameter '$1'"
        usage
        ;;
esac

# Check rsync exit status
if [ $? -eq 0 ]; then
    echo ""
else
    echo ""
    echo "Sync failed with exit code $?"
    exit 1
fi
