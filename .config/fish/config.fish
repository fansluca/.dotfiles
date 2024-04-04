if status is-interactive
    # Commands to run in interactive sessions can go here
    export PATH="$PATH:$HOME/.local/bin"

    set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
    set -x MANROFFOPT -c

    starship init fish | source

    set -x _ZO_ECHO 1
    zoxide init --cmd cd fish | source

    # eval (zellij setup --generate-auto-start fish | string collect)

end
