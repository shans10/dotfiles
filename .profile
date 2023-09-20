# Find out which distribution we are running on
# _distro=$(awk '/^ID=/' /etc/*-release | awk -F'=' '{ print tolower($2) }')

# Set an icon based on the distro
# case $_distro in
#     *kali*)                  ICON="ﴣ";;
#     *arch*)                  ICON="";;
#     *debian*)                ICON="";;
#     *raspbian*)              ICON="";;
#     *ubuntu*)                ICON="";;
#     *elementary*)            ICON="";;
#     *fedora*)                ICON="";;
#     *coreos*)                ICON="";;
#     *gentoo*)                ICON="";;
#     *mageia*)                ICON="";;
#     *centos*)                ICON="";;
#     *opensuse*|*tumbleweed*) ICON="";;
#     *sabayon*)               ICON="";;
#     *slackware*)             ICON="";;
#     *linuxmint*)             ICON="";;
#     *alpine*)                ICON="";;
#     *aosc*)                  ICON="";;
#     *nixos*)                 ICON="";;
#     *devuan*)                ICON="";;
#     *manjaro*)               ICON="";;
#     *rhel*)                  ICON="";;
#     *)                       ICON="";;
# esac

# export STARSHIP_DISTRO="$ICON "

# General env
export EDITOR="nvim"
# export VISUAL="emacs"
export VISUAL="emacsclient -cn -a emacs"

# Firefox Precision Scrolling
export MOZ_USE_XINPUT2=1

# Set session type for startx
# export XDG_SESSION_TYPE=x11

# Set fzf theme(catppuccin)
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# Automatically run startx on login
# if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
#   exec startx
# fi
