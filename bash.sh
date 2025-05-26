#!/bin/bash

source packages.conf

echo "Works fine"

NVIM_V="v0.11.1"
# NVIM_V="nightly"

sudo -v
# checking if lazyvim is installed
if command -v nvim >/dev/null 2>&1; then
    echo "nvim is configurated"
else
    echo -e "nvim is not configurated\n     Installing..."
    curl -LO "https://github.com/neovim/neovim/releases/download/${NVIM_V}/nvim-linux-x86_64.tar.gz"

    if [[ -f nvim-linux-x86_64.tar.gz && -s nvim-linux-x86_64.tar.gz ]]; then
        echo "neovim pulled correcly"
    else
        echo "Error in pulling ${NVIM_V} neovim. Exiting..."
        exit 1
    fi

    tar -xzf nvim-linux-x86_64.tar.gz
    sudo mv nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
    sudo cp -r nvim-linux-x86_64/share/nvim /usr/local/share/
    rm nvim-linux-x86_64.tar.gz
    rm -rf nvim-linux-x86_64

fi

if [[ ! -d "${HOME}/.config" ]]; then
    echo "Making the .config file"
    mkdir "${HOME}/.config"
fi

if [[ -d "/home/${USER}/.config/nvim" ]]; then
    echo "nvim alread configurated. The process will end here"
    exit 0
else
    echo "nvim not configurated"
    # It gives error for some reason now
    if dpkg -s git >/dev/null 2>&1; then
        echo "Git installed"
    else
        CMD=$(./get_package_manager.sh git)
        eval "$CMD"
    fi
    git clone https://github.com/TheodorPredescu/nvim-lazyvim_config "${HOME}/.config/nvim"
fi

for package in "${packages[@]}"; do
    if dpkg -s "${package}" >/dev/null 2>&1; then
        echo "${package} is installed."
    else
        echo "${package} is not installed."
        echo "Installing..."
        # sudo apt-get install -y "${package}"
        CMD=$(./get_package_manager.sh "$package")
        eval "$CMD"

        if dpkg -s "${package}" >/dev/null 2>&1; then
            echo "${package} has installed correcly."
        else
            echo "${package} failed to install."
        fi

    fi
done

#For luarocks
if command -v luarocks >/dev/null 2>&1; then
    echo "luarocks is already installed."
else
    echo "Installing luarocks..."
    CMD_ROCKS=$(./get_package_manager.sh luarocks)
    if ! eval "$CMD_ROCKS"; then
        echo "Failed to install luarocks."
        exit 1
    fi
fi
