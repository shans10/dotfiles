### USER SETTINGS ###

## ALIASES
#
# distrobox
alias dex='distrobox-host-exec'

# Replace ls with exa
if [[ -x "$(command -v eza)" ]]; then
    alias ls='eza --git --icons --color=always --group-directories-first'
    alias la='eza -la --git --icons --color=always --group-directories-first'
    alias lh='eza -a --git --icons --color=always --group-directories-first'
fi

# Package management
DISTRO="$(awk '/^ID=/' /etc/*-release | awk -F'=' '{ print tolower($2) }')"
if [[ "$DISTRO" == "arch" ]]; then
    alias pac-in='sudo pacman -S'
    alias pac-rm='sudo pacman -Rns'
    alias pac-up='sudo pacman -Syu'
elif [[ "$DISTRO" == "fedora" ]]; then
    alias dnf-in='sudo dnf install'
    alias dnf-rm='sudo dnf remove'
    alias dnf-up='sudo dnf update'
elif [[ "$DISTRO" == '"opensuse-tumbleweed"' ]]; then
    alias zyp-in='sudo zypper in'
    alias zyp-rm='sudo zypper rm --clean-deps'
    alias zyp-up='sudo zypper dup'
fi

# Helix
if [[ -x "$(command -v helix)" ]]; then
    alias hx='helix'
fi

## EXTERNAL MODULES
#
# Starship prompt
if [[ -x "$(command -v starship)" ]]; then
    eval "$(starship init bash)"
fi

# Zoxide support
if [[ -x "$(command -v zoxide)" ]]; then
    eval "$(zoxide init bash)"
fi

# direnv support
if [[ -x "$(command -v direnv)" ]]; then
    eval "$(direnv hook bash)"
fi

## HIGHLIGHTING
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
