### FISH ESSENTIALS ###

# No greeting when starting an interactive shell.
set -U fish_greeting

# Ctrl-C Binding
function fish_user_key_bindings
  bind \cc 'echo; commandline | cat; commandline ""; commandline -f repaint'
end


### PROMPT ###

# Starship PROMPT
starship init fish | source


### FUNCTIONS ###

# Bash Style Command Substitution and Chaining
# Bang Bang(Previous Command)
function bind_bang
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end
#(Last Argument of previous command)
function bind_dollar
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end
# Setting the bindings
function fish_user_key_bindings
  bind ! bind_bang
  bind '$' bind_dollar
end

### Emacs Vterm Settings
# Shell-side configuration
function vterm_printf;
    if [ -n "$TMUX" ]
        # tell tmux to pass the escape sequences through
        # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
        printf "\ePtmux;\e\e]%s\007\e\\" "$argv"
    else if string match -q -- "screen*" "$TERM"
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$argv"
    else
        printf "\e]%s\e\\" "$argv"
    end
end

# vterm-clear-scrollback
if [ "$INSIDE_EMACS" = 'vterm' ]
    function clear
        vterm_printf "51;Evterm-clear-scrollback";
        tput clear;
    end
end


### ALIASES ###

## ARCH LINUX
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
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'

# Mirror Update to latest top 200 mirrors
alias mirror-update='sudo reflector --country India --latest 5 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist'


## Pop!_OS(Debian/Ubuntu based)
# Aliases for package management(apt)
alias update='sudo apt update'
alias upgrade='sudo apt upgrade'
alias install='sudo apt install'
alias remove='sudo apt remove --purge'
alias autoremove='sudo apt autoremove'
alias autoclean='sudo dnf autoclean'


## FEDORA
# Aliases for package managment
alias update='sudo dnf update'
alias install='sudo dnf install'
alias remove='sudo dnf remove'
alias search='sudo dnf search'
alias autoremove='sudo dnf autoremove'


## OPENSUSE
# Aliases for package management
alias up='sudo zypper up'
alias in='sudo zypper in'
alias se='sudo zypper se'
alias dup='sudo zypper dup'
alias rem='sudo zypper rm'
alias ref='sudo zypper refresh'
alias red='sudo zypper rm --clean-deps'


## CLEAR LINUX
# Aliases for package managment(swupd)
alias update='sudo swupd update'
alias add='sudo swupd bundle-add'
alias remove='sudo swupd bundle-remove'
alias search='sudo swupd search'
alias clean='sudo swupd clean'

# Set feh background and default image size
# alias feh='feh --image-bg "#1d2021" --scale-down --auto-zoom'

# Replace ls with exa
alias ls='exa --icons --group-directories-first'
alias la='exa -la --icons --group-directories-first'
alias lh='exa -a --icons --group-directories-first'

# Alias for edit command
alias edit='emacsclient -cn -a emacs'


### HIGHLIGHTING ###

# Use terminal colorscheme
set fish_color_autosuggestion      brblack
set fish_color_cancel              -r
set fish_color_command             brgreen
set fish_color_comment             brmagenta
set fish_color_cwd                 green
set fish_color_cwd_root            red
set fish_color_end                 brmagenta
set fish_color_error               brred
set fish_color_escape              brcyan
set fish_color_history_current     --bold
set fish_color_host                normal
set fish_color_match               --background=brblue
set fish_color_normal              normal
set fish_color_operator            cyan
set fish_color_param               brblue
set fish_color_quote               yellow
set fish_color_redirection         bryellow
set fish_color_search_match        'bryellow' '--background=brblack'
set fish_color_selection           'white' '--bold' '--background=brblack'
set fish_color_status              red
set fish_color_user                brgreen
set fish_color_valid_path          --underline
set fish_pager_color_completion    normal
set fish_pager_color_description   yellow
set fish_pager_color_prefix        'white' '--bold' '--underline'
set fish_pager_color_progress      'brwhite' '--background=cyan'
