#!/bin/bash

source packages.conf

echo "Works fine"

for package in ${packages[@]}; do
    if dpkg -s ${package} >/dev/null 2>&1; then
        echo "${package} is installed."
    else
        echo "${package} is not installed."
        echo "Installing..."
    fi
done
