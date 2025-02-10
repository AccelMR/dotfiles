import subprocess
import time

MAX_VOLUME = 100
MAX_MIX_VALUE = 128
HALF_MIX_VALUE = MAX_MIX_VALUE // 2

def get_chatmix_value():
    """
    Run headsetcontrol -m and extract the Chatmix value.
    """
    try:
        result = subprocess.run(["headsetcontrol", "-m"], capture_output=True, text=True, check=True)
        for line in result.stdout.splitlines():
            if "Chatmix:" in line:
                return int(line.split(":")[1].strip())
    except subprocess.CalledProcessError as e:
        print(f"Error running headsetcontrol: {e}")
    return None

def calculate_volumes(chatmix_value):
    """
    Calculate volumes for GameOutput and ChatOutput based on the refined model.
    """

    if chatmix_value <= HALF_MIX_VALUE:
        game_volume = MAX_VOLUME
        chat_volume = int((chatmix_value / HALF_MIX_VALUE) * game_volume)
    else:
        chat_volume = MAX_VOLUME
        game_volume = int(((MAX_MIX_VALUE - chatmix_value) / HALF_MIX_VALUE) * chat_volume)

    return game_volume, chat_volume

def set_volumes(game_volume, chat_volume, game_sink, chat_sink):
    """
    Set the volumes for GameOutput and ChatOutput sinks.
    """
    subprocess.run(["pactl", "set-sink-volume", game_sink, f"{game_volume}%"])
    subprocess.run(["pactl", "set-sink-volume", chat_sink, f"{chat_volume}%"])
    print(f"Set GameOutput to {game_volume}% and ChatOutput to {chat_volume}%")

def main():
    # Sinks
    game_sink = "GameOutput"
    chat_sink = "ChatOutput"

    while True:
        # Get the Chatmix value
        chatmix_value = get_chatmix_value()

        if chatmix_value is not None:
            game_volume, chat_volume = calculate_volumes(chatmix_value)
            set_volumes(game_volume, chat_volume, game_sink, chat_sink)
        else:
            print("Failed to get Chatmix value.")

        # Sleep before running again
        time.sleep(1)  # Adjust interval as needed

if __name__ == "__main__":
    main()
