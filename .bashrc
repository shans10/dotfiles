### USER SETTINGS ###

## ALIASES
#
# Replace ls with exa
if [[ -x "$(command -v eza)" ]]; then
    alias ls='eza --git --icons --color=always --group-directories-first'
    alias la='eza -la --git --icons --color=always --group-directories-first'
    alias lh='eza -a --git --icons --color=always --group-directories-first'
fi

# home-manager
if [[ -x "$(command -v home-manager)" ]]; then
    alias hm='home-manager'
    alias hms='home-manager switch'
fi

# chezmoi
if [[ -x "$(command -v chezmoi)" ]]; then
    alias cz='chezmoi'
fi

# distrobox
if [[ -x "$(command -v distrobox)" ]]; then
    alias dbc='distrobox create'
    alias dbe='distrobox enter'
    alias dbr='distrobox rm'
    alias dbx='distrobox'
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
# export LESS_TERMCAP_mb=$'\e[1;32m'
# export LESS_TERMCAP_md=$'\e[1;32m'
# export LESS_TERMCAP_me=$'\e[0m'
# export LESS_TERMCAP_se=$'\e[0m'
# export LESS_TERMCAP_so=$'\e[01;33m'
# export LESS_TERMCAP_ue=$'\e[0m'
# export LESS_TERMCAP_us=$'\e[1;4;31m'
# export MANROFFOPT="-c"
