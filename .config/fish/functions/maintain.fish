# Function to perform a full system cleanup and update
# This script handles both pacman and yay cache cleaning

function maintain
  echo "--- Starting System Update ---"
  yay -Syu
  
  echo "--- Cleaning Package Cache ---"
  # Remove uninstalled package cache
  sudo pacman -Sc --noconfirm
  
  echo "--- Checking for Orphaned Packages ---"
  # List orphans if any exist
  set orphans (pacman -Qdtq)
  if test -n "$orphans"
    sudo pacman -Rs $orphans
  else
    echo "No orphans to remove."
  end

# Clean up corrupted or leftover download directories
  if test -n "$(find /var/cache/pacman/pkg/ -maxdepth 1 -name 'download-*' -print -quit 2>/dev/null)"
    echo "--- Cleaning leftover download artifacts ---"
    sudo find /var/cache/pacman/pkg/ -maxdepth 1 -name 'download-*' -exec rm -rf {} +
  end
end