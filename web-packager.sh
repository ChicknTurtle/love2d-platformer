#!/bin/bash

# Running this file will package the game and
# start a temperary web server for testing it.
# by ChicknTurtle

# Make sure makelove is installed
if python -c "import makelove" &> /dev/null; then
    echo "makelove is already installed."
else
    echo "makelove is not installed. Installing..."
    pip install makelove
    if [ $? -eq 0 ]; then
        echo "makelove installed successfully."
    else
        echo "Failed to install makelove!"
        exit 1
    fi
fi

# package the game
echo "Packaging game..."
makelove lovejs --config webgame/makelove.toml &> /dev/null

# unzip the game
echo "Unzipping..."
unzip -o webgame/lovejs/webgame-lovejs.zip -d webgame &> /dev/null

# start the web server
echo "Starting web server..."
python -m http.server --directory webgame &> /dev/null
