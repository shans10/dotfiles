# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/shan/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

### USER SETTINGS ###
## Aliases
if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

# Up/Down partial search
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

## Plugins
# Autosuggestions
if [ -f ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Syntax highlighting
if [ -f ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# History substring search
# if [ -f ~/.zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh ]; then
#     source ~/.zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
#     bindkey '^[[A' history-substring-search-up
#     bindkey '^[[B' history-substring-search-down
# fi

## External plugins
# Starship prompt
if command -v starship &> /dev/null; then
    eval "$(starship init zsh)"
fi

# Zoxide support
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
fi
