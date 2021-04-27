# Paths
export PATH=/opt:/bin:~/Docs/Scripts:~/Docs/Scripts/dwmblocks:$HOME/.cargo/bin:$PATH
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export JAVA_HOME=/usr/lib/jvm/java-14-openjdk
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/history"
export ANDROID_SDK_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/android"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export GTK3_RC_FILES="$XDG_CONFIG_HOME"/gtk-3.0/settings.ini
#export QT_QPA_PLATFORMTHEME=gtk2
export LANG=en_US.UTF-8

source "$HOME/.cargo/env"

# Default Apps
export EDITOR="nvim"
export VISUAL="nvim"
export READER="mupdf"
export PAGER="less"
export TERMINAL="kitty"
export BROWSER="LibreWolf"
export VIDEO="mpv"
export IMAGE="sxiv"
export COLORTERM="truecolor"
export OPENER="xdg-opener"
export WM="dwm"
export CODEEDITOR="code"

# Clipmenu
export CM_SELECTIONS="clipboard"
export CM_DEBUG=1
export CM_OUTPUT_CLIP=0
export CM_MAX_CLIPS=50
export CM_HISTLENGTH=5
export CM_LAUNCHER="dmenu"
export CM_IGNORE_WINDOW="(KeePassXC)"

if [[ "$(tty)" = "/dev/tty1" ]]; then
    pgrep dwm || startx
fi
