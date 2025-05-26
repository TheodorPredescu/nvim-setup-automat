#!/bin/bash

# Get the package name from argument
PACKAGE="$1"

# Determine package manager and return install command
if command -v apt >/dev/null; then
    echo "sudo apt update && sudo apt install -y $PACKAGE"
elif command -v dnf >/dev/null; then
    echo "sudo dnf install -y $PACKAGE"
elif command -v yum >/dev/null; then
    echo "sudo yum install -y $PACKAGE"
elif command -v pacman >/dev/null; then
    echo "sudo pacman -Sy --noconfirm $PACKAGE"
elif command -v zypper >/dev/null; then
    echo "sudo zypper install -y $PACKAGE"
elif command -v apk >/dev/null; then
    echo "sudo apk add $PACKAGE"
elif command -v emerge >/dev/null; then
    echo "sudo emerge $PACKAGE"
else
    echo "echo 'Unsupported package manager'" # fallback
fi
