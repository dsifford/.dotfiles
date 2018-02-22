#!/usr/bin/env bash

if ! command -v wget > /dev/null; then
    echo '[WARN] is not installed. Skipping plugin update...'
    exit 1
fi

PLUGINS_DIR=~/.dotfiles/.lib/plugins

plugin_sources=(
    https://raw.githubusercontent.com/d12frosted/dotbot-brew/master/brew.py
    https://raw.githubusercontent.com/ajlende/dotbot-pacaur/master/pacaur.py
)

for src in "${plugin_sources[@]}"; do
    wget -nc -q --show-progress -P "$PLUGINS_DIR" "$src"
done
