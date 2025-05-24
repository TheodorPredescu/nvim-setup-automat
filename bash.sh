#!/bin/bash

source packages.conf

echo "Works fine"

sudo -v
# checking if lazyvim is installed
if dpkg -s neovim >/dev/null 2>&1; then
    echo "nvim is configurated"
else
    echo -e "nvim is not configurated\n     Installing..."
    curl -LO https://github.com/neovim/neovim/releases/download/v0.11.1/nvim.appimage
    chmod u+x nvim.appimage
    sudo mv nvim.appimage /usr/local/bin/nvim
fi

if [[ -d ${HOME}/.config ]]; then
    echo "Making the .config file"
    mkdir "${HOME}/.config"
fi

if [[ -d "/home/${USER}/.config/nvim" ]]; then
    echo "nvim alread configurated. The process will end here"
    exit 0
else
    echo "nvim not configurated"
    git clone https://github.com/TheodorPredescu/nvim-lazyvim_config "${HOME}/.config/nvim"
fi

# for package in "${packages[@]}"; do
#     if dpkg -s "${package}" >/dev/null 2>&1; then
#         echo "${package} is installed."
#     else
#         echo "${package} is not installed."
#         echo "Installing..."
#     fi
# done
