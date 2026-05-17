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
            alias install 'paru -S --skipreview'
            alias update 'paru -Syu --skipreview'
            alias remove 'paru -Rns'
            alias search 'paru -Ss'
        else if type -q yay
            alias install 'yay -S'
            alias update 'yay -Syu'
            alias remove 'yay -Rns'
            alias search 'yay -Ss'
        end
        alias cleanup 'sudo pacman -Rns (pacman -Qtdq)'

    case ubuntu debian linuxmint pop
        alias install 'sudo apt install'
        alias update 'sudo apt update && sudo apt upgrade'
        alias remove 'sudo apt remove --purge'
        alias cleanup 'sudo apt autoremove --purge'
        alias search 'apt search'

    case fedora
        alias install 'sudo dnf install'
        alias update 'sudo dnf upgrade'
        alias remove 'sudo dnf remove'
        alias cleanup 'sudo dnf autoremove'
        alias search 'dnf search'

    case opensuse-leap opensuse-tumbleweed
        alias install 'sudo zypper install'
        alias update 'sudo zypper update'
        alias remove 'sudo zypper remove'
        alias cleanup 'sudo zypper packages --unneeded | awk "{print \$5}" | xargs sudo zypper remove'
        alias search 'zypper search'
end

# MacOS like 'open' command behaviour
function open
    # If no argument is provided, default to "." (current directory)
    set -l target $argv[1]
    if test -z "$target"
        set target "."
    end

    # Run in background and send all output to /dev/null
    nohup xdg-open $target >/dev/null 2>&1 & disown

    # "disown" isn't strictly needed in fish with & for most GUI apps,
    # but "nohup" ensures it stays open if you close the terminal.
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

# Replace grep with rg
if type -q rg
    alias grep 'rg --smart-case'
end

# Opencode
type -q opencode; and alias oc opencode

# Emacs
type -q emacs; and alias emt 'emacsclient -t -a ""'

# Zellij
type -q zellij; and alias zj zellij

# go-grip
type -q go-grip; and alias grip go-grip

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
# Zoxide support
type -q zoxide; and zoxide init fish | source

# direnv support
type -q direnv; and direnv hook fish | source

# Set up fzf key bindings
type -q fzf; and fzf --fish | source

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba shell init' !!
if test -d /home/shan/.miniforge
    set -gx MAMBA_EXE "/home/shan/.miniforge/bin/mamba"
    set -gx MAMBA_ROOT_PREFIX "/home/shan/.miniforge"
    $MAMBA_EXE shell hook --shell fish --root-prefix $MAMBA_ROOT_PREFIX | source
    # Replace conda with mamba
    alias conda mamba
end
# <<< mamba initialize <<<

# Prevent Python and Conda/Mamba virtual environments from injecting
# their own prompt prefixes, allowing Starship to handle it completely.
set -gx VIRTUAL_ENV_DISABLE_PROMPT 1
set -gx CONDA_CHANGEPS1 no
set -gx MAMBA_CHANGEPS1 no
set -gx CONDA_LEFT_PROMPT 1

# Starship prompt (Keep this at the end to ensure it overrides other prompt modifications)
type -q starship; and starship init fish | source
