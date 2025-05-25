### ALIASES
#
# Replace ls with exa
if [[ -x "$(command -v eza)" ]]; then
    alias ls='eza --git --icons --color=always --group-directories-first'
    alias la='eza -a --git --icons --color=always --group-directories-first'
    alias ll='eza -la --git --icons --color=always --group-directories-first'
fi

# Host commands
alias hx='distrobox-host-exec hx'

# Package Management
# Find out which distribution we are running on
_distro=$(awk '/^ID=/' /etc/*-release | awk -F'=' '{ print tolower($2) }')

# Set aliases based on distro
case $_distro in
    *debian*|*ubuntu*)
        alias update='sudo apt update && sudo apt upgrade'
        alias install='sudo apt install'
        alias remove='sudo apt remove --purge'
        alias search='sudo apt search'
    ;;
    *fedora*)
        alias update='sudo dnf update'
        alias install='sudo dnf install'
        alias remove='sudo dnf remove'
        alias search='sudo dnf search'
    ;;
    *opensuse*|*tumbleweed*)
        alias install='sudo zypper in --no-recommends'
        alias update='sudo zypper dup --no-recommends'
        alias remove='sudo zypper rm --clean-deps'
        alias search='sudo zypper search'
    ;;
esac

### EXTERNAL MODULES
#
# Starship prompt
if [[ -x "$(command -v starship)" ]]; then
    eval "$(starship init bash)"
fi

# Zoxide support
if [[ -x "$(command -v zoxide)" ]]; then
    eval "$(zoxide init bash)"
fi

### HIGHLIGHTING
#
# Add colors to manpages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'
export MANROFFOPT="-c"

### INTERACTIVE SHELL
# 
# Start fish shell
if [[ -x "$(command -v fish)" ]]; then
    exec fish
fi
