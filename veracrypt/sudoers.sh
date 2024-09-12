#!/bin/sh

set -e # Exit immediately if a command exits with a non-zero status.
set -u # Treat unset variables as an error.

echo "app ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/veracrypt

chmod 440 /etc/sudoers.d/veracrypt

# echo "Defaults logfile=/var/log/sudo" > /etc/sudoers.d/logging

# chmod 440 /etc/sudoers.d/loggingdocke