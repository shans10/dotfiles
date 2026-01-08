### FISH ESSENTIALS ###
#
# Terminal title
function fish_title
    if set -q SSH_TTY
        set host (hostname -s)
    else
        set host (hostname -s)
    end

    if set -q argv[1]
        echo $argv
    else
        echo (whoami)@$host:(prompt_pwd)
    end
end

# No greeting when starting an interactive shell.
set -U fish_greeting

# Bash Style Command Substitution and Chaining
# Bang Bang(Previous Command)
function bind_bang
    switch (commandline -t)
        case "!"
            commandline -t $history[1]
            commandline -f repaint
        case "*"
            commandline -i !
    end
end
#(Last Argument of previous command)
function bind_dollar
    switch (commandline -t)
        case "!"
            commandline -t ""
            commandline -f history-token-search-backward
        case "*"
            commandline -i '$'
    end
end
# Setting the bindings
function fish_user_key_bindings
    bind ! bind_bang
    bind '$' bind_dollar
end

### ALIASES ###
#
# Package management (Distro agnostic)
# Read distro ID safely
set -l ID (grep '^ID=' /etc/os-release | head -n1 | string replace 'ID=' '' | string trim -c '"')

switch $ID
    case arch manjaro endeavouros cachyos
        if type -q paru
            alias install 'paru -S'
            alias update  'paru -Syu'
            alias remove  'paru -Rns'
            alias search  'paru -Ss'
        else if type -q yay
            alias install 'yay -S'
            alias update  'yay -Syu'
            alias remove  'yay -Rns'
            alias search  'yay -Ss'
        end
        alias cleanup 'sudo pacman -Rns (pacman -Qtdq)'

    case ubuntu debian linuxmint pop
        alias install 'sudo apt install'
        alias update  'sudo apt update && sudo apt upgrade'
        alias remove  'sudo apt remove --purge'
        alias cleanup 'sudo apt autoremove --purge'
        alias search  'apt search'

    case fedora
        alias install 'sudo dnf install'
        alias update  'sudo dnf upgrade'
        alias remove  'sudo dnf remove'
        alias cleanup 'sudo dnf autoremove'
        alias search  'dnf search'

    case opensuse-leap opensuse-tumbleweed
        alias install 'sudo zypper install'
        alias update  'sudo zypper update'
        alias remove  'sudo zypper remove'
        alias cleanup 'sudo zypper packages --unneeded | awk "{print \$5}" | xargs sudo zypper remove'
        alias search  'zypper search'
end

# Replace ls with eza
if type -q eza
    alias ls 'eza --git --icons --color=always --group-directories-first --classify=auto'
    alias la 'ls -a'
    alias ll 'ls -la'
end

# Replace cat with bat
type -q bat; and function cat
    isatty stdout; and bat --paging=never --style=plain --color=always $argv
    or command cat $argv
end

# Chezmoi
type -q chezmoi; and alias cz chezmoi

# Zellij
type -q zellij; and alias zj zellij

# Use 'fzf-zellij' instead of 'fzf' if inside zellij
if type -q fzf-zellij
    function fzf
        switch $argv[1]
            case --bash --zsh --fish --version -h --help --man
                command fzf $argv
            case '*'
                fzf-zellij $argv
        end
    end
end

### EXTERNAL MODULES ###
#
# Starship prompt
type -q starship; and starship init fish | source

# Zoxide support
type -q zoxide; and zoxide init fish | source

# direnv support
type -q direnv; and direnv hook fish | source

# Set up fzf key bindings
type -q fzf; and fzf --fish | source
