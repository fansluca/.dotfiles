if status is-interactive
    # Commands to run in interactive sessions can go here
    export PATH="$PATH:$HOME/.local/bin"

    # ~/.config/fish/config.fish
    starship init fish | source

    set -x _ZO_ECHO 1
    zoxide init --cmd cd fish | source

end
