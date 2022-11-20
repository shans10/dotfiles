# Aliases for package managment
# pacman
alias pupdate='sudo pacman -Syu'
alias pinstall='sudo pacman -S'
alias premove='sudo pacman -Rns'

# yay as aur helper - updates everything
alias update="yay -Syu"
alias install="yay -S"
alias remove='yay -Rns'

# Cleanup orphaned packages
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'

# Replace ls with exa
alias ls='exa --git --icons --color=always --group-directories-first'
alias la='exa -la --git --icons --color=always --group-directories-first'
alias lh='exa -a --git --icons --color=always --group-directories-first'

# Alias for edit command
# alias edit='emacsclient -cn -a emacs'
alias edit='nvim'

# Feh background
alias feh='feh -B "#1a1b26" -.'
