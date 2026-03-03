#!/bin/bash

music_icon="$HOME/.config/swaync/assets/music.png"

# Play the next track
play_next() {
    playerctl next
    show_music_notification
}

# Play the previous track
play_previous() {
    playerctl previous
    show_music_notification
}

# Toggle play/pause
toggle_play_pause() {
    playerctl play-pause
    sleep 0.2  # Short delay to ensure the status is updated before showing the notification
    show_music_notification
}

# Stop playback
stop_playback() {
    playerctl stop
    notify-send -a "music-control" -i "$music_icon" "Playback Stopped"
}

# Display swaync notification with song information
show_music_notification() {
    status=$(playerctl status)
    if [[ "$status" == "Playing" ]]; then
        song_title=$(playerctl metadata title)
        song_artist=$(playerctl metadata artist)
        notify-send -a "music-control" -i "$music_icon" "Now Playing:" "$song_title\nby $song_artist"
    elif [[ "$status" == "Paused" ]]; then
        notify-send -a "music-control" -i "$music_icon" "Playback Paused"
    fi
}

# Get media control action from command line argument
case "$1" in
    "--nxt")
        play_next
        ;;
    "--prv")
        play_previous
        ;;
    "--pause")
        toggle_play_pause
        ;;
    "--stop")
        stop_playback
        ;;
    *)
        echo "Usage: $0 [--nxt|--prv|--pause|--stop]"
        exit 1
        ;;
esac