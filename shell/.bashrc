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

# Replace grep with rg
if command -v rg >/dev/null 2>&1; then
    alias grep='rg --smart-case'
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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/home/shan/.miniforge/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/home/shan/.miniforge/etc/profile.d/conda.sh" ]; then
#         . "/home/shan/.miniforge/etc/profile.d/conda.sh"
#     else
#         export PATH="/home/shan/.miniforge/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# <<< conda initialize <<<

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba shell init' !!
# export MAMBA_EXE='/home/shan/.miniforge/bin/mamba';
# export MAMBA_ROOT_PREFIX='/home/shan/.miniforge';
# __mamba_setup="$("$MAMBA_EXE" shell hook --shell bash --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__mamba_setup"
# else
#     alias mamba="$MAMBA_EXE"  # Fallback on help from mamba activate
# fi
# unset __mamba_setup
# <<< mamba initialize <<<

# Replace conda with mamba
# alias conda='mamba'
