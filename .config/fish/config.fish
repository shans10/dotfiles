### FISH ESSENTIALS ###

# No greeting when starting an interactive shell.
set -U fish_greeting

# Ctrl-C Binding
function fish_user_key_bindings
  bind \cc 'echo; commandline | cat; commandline ""; commandline -f repaint'
end


### PROMPT ###

# Finding distro name
set _distro (awk '/^ID=/' /etc/*-release | awk -F'=' '{ print tolower($2) }')

# Set an icon based on the distro
switch $_distro
    case kali
        set ICON "ﴣ"
    case arch
        set ICON ""
    case debian
        set ICON ""
    case raspbian
        set ICON ""
    case ubuntu
        set ICON ""
    case elementary
        set ICON ""
    case fedora
        set ICON ""
    case coreos
        set ICON ""
    case gentoo
        set ICON ""
    case mageia
        set ICON ""
    case centos
        set ICON ""
    case opensuse tumbleweed
        set ICON ""
    case sabayon
        set ICON ""
    case slackware
        set ICON ""
    case linuxmint
        set ICON ""
    case alpine
        set ICON ""
    case aosc
        set ICON ""
    case nixos
        set ICON ""
    case devuan
        set ICON ""
    case manjaro
        set ICON ""
    case rhel
        set ICON ""
    case '*'
        set ICON ""
end

export STARSHIP_DISTRO="$ICON "

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

## Bootloader
# systemd-boot update
alias boot-up="sudo bootctl update"

# Grub Update
alias grub-update='sudo grub-mkconfig -o /boot/grub/grub.cfg'

## Generate initramfs
alias initramfs-gen='sudo mkinitcpio -p linux'

# Set feh background and default image size
# alias feh='feh --image-bg "#1d2021" --scale-down --auto-zoom'

# Replace ls with exa
alias ls='exa --icons --group-directories-first'
alias la='exa -la --icons --group-directories-first'
alias lh='exa -a --icons --group-directories-first'

# Alias for edit command
alias edit='emacsclient -cn -a emacs'


### SETTING FISH ENVIRONMENT VARIABLES ###

set -gx TERM "xterm-256color"               # Sets the terminal type
set -gx EDITOR "alacritty -e nvim"          # $EDITOR use Neovim in terminal
set -gx VISUAL "emacsclient -cn -a emacs"   # $VISUAL use Emacs


### ADDITIONAL CONFIGURATION ###

# Zoxide(z style cd)
# zoxide init fish | source

# Use neovim for reading manpages
# export MANPAGER="/bin/sh -c \"col -b | nvim -c 'set ft=man ts=8 nomod nolist nonu noma' -\""

# Flatpak XDG_DATA_DIRS Workaround
# set -l xdg_data_home $XDG_DATA_HOME ~/.local/share
# set -gx --path XDG_DATA_DIRS $xdg_data_home[1]/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share

# for flatpakdir in ~/.local/share/flatpak/exports/bin /var/lib/flatpak/exports/bin
#     if test -d $flatpakdir
#         contains $flatpakdir $PATH; or set -a PATH $flatpakdir
#     end
# end

# QT applications theming in twm
# export QT_QPA_PLATFORMTHEME=qt5ct

# Firefox Precision Scrolling
# export MOZ_USE_XINPUT2=1

# Start X at login
# if status --is-login
#   if test -z "$DISPLAY" -a $XDG_VTNR = 1
#     exec startx -- -keeptty
#   end
# end
