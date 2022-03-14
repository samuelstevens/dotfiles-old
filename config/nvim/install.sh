#!/usr/bin/env bash

set -euo pipefail

echo "This script tells you the instructions to make a virtual environment to provide Python to Neovim."
echo
echo "mkdir -p ~/.local/venv && cd ~/.local/venv"
echo "  This makes the hidden virtualenv directory."
echo
echo "python3 -m venv nvim"
echo "  This makes a new virtualenv called nvim. You might have to set up python3 to point to a particular version of python."
echo
echo "source nvim/bin/activate"
echo "  This activates the virtualenv."
echo
echo "pip install pynvim black"
echo "  Neovim requires pynvim to be installed. I require black to be installed for averms/black-nvim."
echo
echo "  Then run :UpdateRemotePlugins inside nvim. The post-install hook for black-nvim hasn't worked for me in the past."
