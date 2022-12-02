# Find out which distribution we are running on
_distro=$(awk '/^ID=/' /etc/*-release | awk -F'=' '{ print tolower($2) }')

# Set an icon based on the distro
case $_distro in
    *kali*)                  ICON="ﴣ";;
    *arch*)                  ICON="";;
    *debian*)                ICON="";;
    *raspbian*)              ICON="";;
    *ubuntu*)                ICON="";;
    *elementary*)            ICON="";;
    *fedora*)                ICON="";;
    *coreos*)                ICON="";;
    *gentoo*)                ICON="";;
    *mageia*)                ICON="";;
    *centos*)                ICON="";;
    *opensuse*|*tumbleweed*) ICON="";;
    *sabayon*)               ICON="";;
    *slackware*)             ICON="";;
    *linuxmint*)             ICON="";;
    *alpine*)                ICON="";;
    *aosc*)                  ICON="";;
    *nixos*)                 ICON="";;
    *devuan*)                ICON="";;
    *manjaro*)               ICON="";;
    *rhel*)                  ICON="";;
    *)                       ICON="";;
esac

export STARSHIP_DISTRO="$ICON "

# Path
export PATH=$PATH:/home/$USER/.local/bin:/home/$USER/.bin/dmscripts

# General env
export TERM=xterm-256color
export EDITOR="nvim"
export VISUAL="emacs"
# export VISUAL="emacsclient -cn -a emacs"

# Firefox Precision Scrolling
export MOZ_USE_XINPUT2=1

# Bat Theme
# export BAT_THEME="base16"

# Use bat for reading manpages
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Set session type for startx
export XDG_SESSION_TYPE=x11

# Automatically run startx on login
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
