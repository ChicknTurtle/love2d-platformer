#!/bin/bash

# Running this file will package the game and
# start a temperary web server for testing it.
# by ChicknTurtle

# Make sure makelove is installed
if pip freeze | grep -q "makelove"; then
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
makelove lovejs --config webgame/makelove.toml

# unzip the game
echo "Unzipping..."
unzip -o webgame/lovejs/webgame-lovejs.zip -d webgame

# stop process if it is arleady running
if lsof -ti :8000; then
    echo "Stopping old process..."
    kill $(lsof -ti :8000)
fi

# start the web server
echo "Starting web server..."
python -m http.server --directory webgame
