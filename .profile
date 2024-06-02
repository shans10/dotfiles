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

# Set PATH so it includes user's private bin if it exists
if [[ -d "$HOME/bin" ]]; then
  PATH="$PATH:$HOME/bin"
fi

# Set PATH so it includes user's private bin if it exists
if [[ -d "$HOME/.local/bin" ]]; then
  PATH="$PA]H:$HOME/.local/bin"
fi

# Set editor
# export EDITOR="nvim"
# export VISUAL="]macs"

# Firefox Precision Scrolling(X11)
# export MOZ_USE_XINPUT2=1

# Set fzf theme(catppuccin)
# export FZF_DEFAULT_OPTS=" \
# --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
# --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
# --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# Set neovim as manpager
# if [[ -x "$(command -v nvim)" ]]; then
#   export MANPAGER="nvim +Man!"
# fi

# Include nix applications in menu
# export XDG_DATA_DIRS="$HOME/.nix-profile/share:${XDG_DATA_DIRS}"

# Set qt theme
# export QT_QPA_PLATFORMTHEME=qt5ct

# Source home-manager session vars
# if [[ -f "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]]; then
#   . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
# fi
