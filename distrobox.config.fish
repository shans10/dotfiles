### FISH ESSENTIALS ###

# Terminal title
function fish_title
    if set -q argv[1]
        echo $argv[1]
    else
        echo $USER@(prompt_hostname):(prompt_pwd)
    end
end

# No greeting when starting an interactive shell.
set -U fish_greeting

# Ctrl-C Binding
function fish_user_key_bindings
    bind \cc 'echo; commandline | cat; commandline ""; commandline -f repaint'
end

### FUNCTIONS ###

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

### Emacs Vterm Settings
# Shell-side configuration
function vterm_printf
    if [ -n "$TMUX" ]
        # tell tmux to pass the escape sequences through
        # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
        printf "\ePtmux;\e\e]%s\007\e\\" "$argv"
    else if string match -q -- "screen*" "$TERM"
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$argv"
    else
        printf "\e]%s\e\\" "$argv"
    end
end

# vterm-clear-scrollback
if [ "$INSIDE_EMACS" = vterm ]
    function clear
        vterm_printf "51;Evterm-clear-scrollback"
        tput clear
    end
end

### ALIASES ###
#
# distrobox
alias dex='distrobox-host-exec'

# Replace ls with exa
if command -q eza
    alias ls='eza --git --icons --color=always --group-directories-first'
    alias la='eza -la --git --icons --color=always --group-directories-first'
    alias lh='eza -a --git --icons --color=always --group-directories-first'
end

# Package management
set DISTRO "$(awk '/^ID=/' /etc/*-release | awk -F'=' '{ print tolower($2) }')"
if [ "$DISTRO" = arch ]
    alias pac-in='sudo pacman -S'
    alias pac-rm='sudo pacman -Rns'
    alias pac-up='sudo pacman -Syu'
else if [ "$DISTRO" = fedora ]
    alias dnf-in='sudo dnf install'
    alias dnf-rm='sudo dnf remove'
    alias dnf-up='sudo dnf update'
else if [ "$DISTRO" = '"opensuse-tumbleweed"' ]
    alias zyp-in='sudo zypper in'
    alias zyp-rm='sudo zypper rm --clean-deps'
    alias zyp-up='sudo zypper dup'
end

# Helix
if command -q helix
    alias hx='helix'
end

### EXTERNAL MODULES ###

# Starship prompt
if command -q starship
    starship init fish | source
end

# Zoxide support
if command -q zoxide
    zoxide init fish | source
end

# direnv support
if command -q direnv
    direnv hook fish | source
end

### HIGHLIGHTING ###

# Use terminal colorscheme
set fish_color_autosuggestion brblack
set fish_color_cancel -r
set fish_color_command brgreen
set fish_color_comment brmagenta
set fish_color_cwd green
set fish_color_cwd_root red
set fish_color_end brmagenta
set fish_color_error brred
set fish_color_escape brcyan
set fish_color_history_current --bold
set fish_color_host normal
set fish_color_match --background=brblue
set fish_color_normal normal
set fish_color_operator cyan
set fish_color_param brblue
set fish_color_quote yellow
set fish_color_redirection bryellow
set fish_color_search_match bryellow '--background=brblack'
set fish_color_selection white --bold '--background=brblack'
set fish_color_status red
set fish_color_user brgreen
set fish_color_valid_path --underline
set fish_pager_color_completion normal
set fish_pager_color_description yellow
set fish_pager_color_prefix white --bold --underline
set fish_pager_color_progress brwhite '--background=cyan'

# Add colors to manpages
set -x LESS_TERMCAP_mb (printf '\e[1;32m')
set -x LESS_TERMCAP_md (printf '\e[1;32m')
set -x LESS_TERMCAP_me (printf '\e[0m')
set -x LESS_TERMCAP_se (printf '\e[0m')
set -x LESS_TERMCAP_so (printf '\e[01;33m')
set -x LESS_TERMCAP_ue (printf '\e[0m')
set -x LESS_TERMCAP_us (printf '\e[1;4;31m')
