if status is-interactive
    # ~/.config/fish/config.fish
    starship init fish | source

    set -x _ZO_ECHO 1
    zoxide init --cmd cd fish | source
end
