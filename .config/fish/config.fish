set -g fish_greeting ""

oh-my-posh init fish | source
oh-my-posh init fish --config ~/dotfiles/.config/oh-my-posh/themes/accelTheme.omp.json | source

set -Ux EDITOR micro
set -Ux VISUAL micro
set -Ux SUDO_EDITOR micro

set -x PATH $HOME/p4v/bin/ $PATH

export EDITOR=micro
export VISUAL=micro
export SUDO_EDITOR=micro

export "MICRO_TRUECOLOR"=1

if status is-interactive
    # Commands to run in interactive sessions can go here
end

neofetch
