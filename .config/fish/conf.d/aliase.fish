status is-interactive || exit

# Navigation
function ..
    cd ..
end
function ...
    cd ../..
end
function ....
    cd ../../..
end
function .....
    cd ../../../..
end

# Utilities
function grep
    command grep --color=auto $argv
end

function su
    /bin/su --shell=/usr/bin/fish $argv
end

function ya
    set -l tmp (mktemp -t "yazi-cwd.XXXXX")

    yazi $argv --cwd-file="$tmp"

    if test -f "$tmp"
        set -l cwd (cat -- "$tmp")
        if test -n "$cwd"; and test "$cwd" != "$PWD"
            cd -- "$cwd"
        end
    end

    rm -f -- "$tmp"
end

# git root
function gr --description "Jump to the git root"
    set -l repo_info (command git rev-parse --git-dir --is-inside-git-dir --is-bare-repository --is-inside-work-tree --short HEAD 2> /dev/null)
    test -n "$repo_info"; or return

    set -l cd_up_path (command git rev-parse --show-cdup)

    if test -n $cd_up_path
        cd $cd_up_path
    end
end

# Pastebin: `command | pb` or `pb < /path/to/file`
# More usage: https://fars.ee/#examples
alias pb 'curl -F "c=@-" "https://fars.ee/"'

# mv, rm, cp
# alias mv 'command gmv --interactive --verbose'
# alias rm 'command grm --interactive --verbose'
# alias cp 'command gcp --interactive --verbose'

alias chmox='chmod +x'

alias ls='eza --time-style=iso --icons'
alias ll='eza --time-style=iso --icons --long --header'
alias la='eza --time-style=iso --icons --long --header --all'
alias lg='eza --time-style=iso --icons --long --header --all --git'
alias tree='eza --time-style=iso --icons --tree --level 3'

alias cman="env LANG=zh_CN.UTF-8 man"

alias vim='nvim'
alias cat='bat'
alias more='less'
alias find='fd'
alias df='duf'
alias du='dust'
alias gitui='gitui -t macchiato.ron'
# gitmydot
# https://wiki.archlinux.org/title/Dotfiles#Tracking_dotfiles_directly_with_Git
alias gitdot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
# gitui
alias gituidot='/usr/bin/gitui -t macchiato.ron --directory=$HOME/.dotfiles/ --workdir=$HOME'
# lazygit
alias lazygitdot='/usr/bin/lazygit --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
