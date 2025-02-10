#!/bin/bash

# Function to check if a sink already exists
sink_exists() {
    pactl list sinks short | grep -q "$1"
}

# Function to check if a loopback module already exists
loopback_exists() {
    pactl list modules short | grep -q "$1"
}

# Create GameOutput sink if it doesn't exist
if ! sink_exists "GameOutput"; then
    pactl load-module module-null-sink sink_name=GameOutput sink_properties=device.description="GameOutput"
fi

# Create ChatOutput sink if it doesn't exist
if ! sink_exists "ChatOutput"; then
    pactl load-module module-null-sink sink_name=ChatOutput sink_properties=device.description="ChatOutput"
fi

# Get the name of the Arctis sink
arctis_sink=$(pactl list short sinks | grep -i "arctis" | awk '{print $2}')

# Create loopback for GameOutput to Arctis sink if not already loaded
if ! loopback_exists "source=GameOutput.monitor"; then
    pactl load-module module-loopback source=GameOutput.monitor sink=$arctis_sink
fi

# Create loopback for ChatOutput to Arctis sink if not already loaded
if ! loopback_exists "source=ChatOutput.monitor"; then
    pactl load-module module-loopback source=ChatOutput.monitor sink=$arctis_sink
fi
