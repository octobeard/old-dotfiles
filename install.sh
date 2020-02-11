#!/bin/bash
echo "Copying files to home directory! Warning: will overwrite any existing files!"

cp -v ./.bash* ~
cp -v ./.profile ~
cp -v ./.zshrc ~

source ~/.profile
