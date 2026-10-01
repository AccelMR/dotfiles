  function nav 
    switch $argv[1]
      case config
        cd ~/nvme2TB/Programming/dotfiles/.config
      case chimera
        cd ~/nvme2TB/Programming/Chimera/ChimeraCore/Chimera
      case '*'
        echo "Unknown nav target: $argv[1]"
        return 1
    end
  end
