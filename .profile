# Set PATH so it includes user's local bin if it exists
[ -d "$HOME/.local/bin" ] && case ":$PATH:" in
    *":$HOME/.local/bin:"*) ;;
    *) export PATH="$HOME/.local/bin:$PATH" ;;
esac

# Set editor
if command -v hx >/dev/null 2>&1; then
    export EDITOR=hx
    export VISUAL=hx
elif command -v helix >/dev/null 2>&1; then
    export EDITOR=helix
    export VISUAL=helix
elif command -v nvim >/dev/null 2>&1; then
    export EDITOR=nvim
    export VISUAL=nvim
fi

# fzf settings
if command -v fzf >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --exclude ".git"'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_DEFAULT_OPTS="--height=55% --layout=reverse --border --margin=1"

  # colorscheme(onedark)
  export FZF_DEFAULT_OPTS+=" \
  --color=bg:#282c34,bg+:#3e4451 \
  --color=fg:#abb2bf,fg+:#ffffff \
  --color=hl:#61afef,hl+:#98c379 \
  --color=info:#d19a66,prompt:#e5c07b \
  --color=pointer:#56b6c2,marker:#c678dd \
  --color=spinner:#61afef,header:#e06c75 \
  --color=border:#5c6370,separator:#5c6370 \
  --color=label:#98c379,query:#abb2bf \
  --color=preview-bg:#21252b,preview-fg:#abb2bf"
fi

# bat settings
if command -v bat >/dev/null 2>&1; then
  # theme
  export BAT_THEME="OneHalfDark"

  # Use bat as manpager
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
  export MANROFFOPT="-c"
fi
