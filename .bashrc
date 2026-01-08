### USER SETTINGS ###

## ALIASES
#
# Replace ls with exa
if command -v eza >/dev/null 2>&1; then
    alias ls='eza --git --icons --color=always --group-directories-first --classify=auto'
    alias la='ls -a'
    alias ll='ls -la'
fi

# Replace cat with bat
if command -v bat >/dev/null 2>&1; then
    cat() {
        if [ -t 1 ]; then
            bat --paging=never --style=plain --color=always "$@"
        else
            command cat "$@"
        fi
    }
fi

# Use 'fzf-zellij' instead of 'fzf' if inside zellij
if command -v fzf-zellij >/dev/null 2>&1; then
    fzf() {
        case "$1" in
            --bash|--zsh|--fish|--version|-h|--help|--man)
                command fzf "$@"
                ;;
            *)
                fzf-zellij "$@"
                ;;
        esac
    }
fi

## EXTERNAL MODULES
#
# Starship prompt
command -v starship >/dev/null 2>&1 && eval "$(starship init bash)"

# Zoxide support
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init bash)"

# direnv support
command -v direnv >/dev/null 2>&1 && eval "$(direnv hook bash)"

# Set up fzf key bindings and fuzzy completion
command -v fzf >/dev/null 2>&1 && eval "$(fzf --bash)"
