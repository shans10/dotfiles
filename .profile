# Set PATH so it includes user's private bin if it exists
if [[ -d "$HOME/bin" ]]; then
  PATH="$PATH:$HOME/bin"
fi

# Set PATH so it includes user's private bin if it exists
if [[ -d "$HOME/.local/bin" ]]; then
  PATH="$PATH:$HOME/.local/bin"
fi

# Set editor
# export EDITOR="nvim"
# export VISUAL="emacs"

# Set neovim as manpager
# if [[ -x "$(command -v nvim)" ]]; then
#   export MANPAGER="nvim +Man!"
# fi
