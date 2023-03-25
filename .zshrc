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

## Plugins
# Autosuggestions
if [ -f ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Syntax highlighting
if [ -f ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=blue,underline
    ZSH_HIGHLIGHT_STYLES[precommand]=fg=blue,underline
    ZSH_HIGHLIGHT_STYLES[arg0]=fg=blue
    ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=17
    ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=17
    ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=green
    ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=green
    ZSH_HIGHLIGHT_STYLES[path]=fg=17,underline
    ZSH_HIGHLIGHT_STYLES[default]=fg=17
fi

# History substring search
if [ -f ~/.zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh ]; then
    source ~/.zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
fi

## External plugins
# Starship prompt
eval "$(starship init zsh)"

# Zoxide support
eval "$(zoxide init zsh)"
