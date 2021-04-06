# Disable ctrl-s ctrl-q
stty -ixon

# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/.histfile

# Git
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats ' on  - (%b)'

# Colors and prompt
setopt PROMPT_SUBST
autoload -U colors && colors
PROMPT='╭─ %F{blue}%n%f {%F{red}%~%}%f}
╰─%F{green}${vcs_info_msg_0_}%f  '

# Auto/tab complete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots) # Include hidden files.

# Vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Colors in Man Pages

# Start blinking
export LESS_TERMCAP_mb=$(tput bold; tput setaf 2) # green
# Start bold
export LESS_TERMCAP_md=$(tput bold; tput setaf 2) # green
# Start standout
export LESS_TERMCAP_so=$(tput bold; tput rev; tput setaf 3) # yellow
# End standout
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
# Start underline
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 1) # red
# End bold, blinking standout, underline
export LESS_TERMCAP_me=$(tput sgr0)

# Aliases

alias nv='nvim'

# Ls
#alias \
#    ls='ls -hN --color=auto --group-directories-first'\
#    l='ls'\
#    ll='ls -l'\
#    lsa='ls -alps'

# Lsd
alias \
    ls='lsd -hv'\
    l='ls'\
    ll='ls -l'\
    lsa='ls -lavF'

# Colors and Verbose output
alias \
    cd-='cd ..'\
    grep='grep --color=auto'\
    cp='cp -iv'\
    mv='mv -iv'\
    rm='rm -vI'\
    mkdir='mkdir -pv'

# System space and hardware
alias \
    df='df -h'\
    free='free -mth'\
    du='du -sh'\
    hw="hwinfo --short"

# Configs
alias \
    cpol='nvim ~/.config/polybar/config'\
    cbsp='nvim ~/.config/bspwm/bspwmrc'\
    csxh='nvim ~/.config/sxhkd/sxhkdrc'\
    cterm='nvim ~/.config/termite/config'\
    cstart='nvim ~/.config/bspwm/autostart.sh'\
    czsh='nvim ~/.config/zsh/.zshrc'\
    cnvim='nvim ~/.config/nvim/init.vim'\
    cplug='nvim ~/.config/nvim/vim-plug/plugins.vim'\
    cala='nvim ~/.config/alacritty/alacritty.yml'\
    cki='nvim ~/.config/kitty/kitty.conf'\
    cro='nvim ~/.config/rofi/config.rasi'\
    cpi='nvim ~/.config/picom.conf'\
    cvifm='nvim ~/.config/vifm/vifmrc'

# Folders
alias \
    dscr='cd ~/Docs/Scripts/'

# Services
alias \
    start='sudo systemctl start' \
    status='sudo systemctl status' \
    restart='sudo systemctl restart' \
    stop='sudo systemctl stop' \
    reload='sudo systemctl reload'

# Pacman
alias \
    pac='sudo pacman'\
    pS='pac -S'\
    pR='pac -Rns'\
    pSs='pac -Ss'\
    pQ='pacman -Qs'\
    pC='pac -Rns $(pacman -Qdtq)'\
    pSc='pac -Sc'

# Yay
alias \
    yS='yay -S'\
    yR='yay -Rns'\
    ySs='yay -Ss'\
    ySc='yay -Sc'\
    yYc='yay -Yc'\

# Update Arch Mirror List, System & database
alias \
    mirrors='sudo reflector -c Portugal -c Spain -c Germany -c UK -a 12 -p https --sort rate --save /etc/pacman.d/mirrorlist'\
    update='pac -Syu && yay -Su && echo "#!/bin/sh
echo  0 " > ~/Docs/Scripts/dwmblocks/s-packages && pkill -RTMIN+4 dwmblocks'\
    check='check_updates '\
    updatedb='sudo updatedb'


# Network Manager
alias \
    nm-scan='nmcli device wifi list'\
    nm-connect='nmcli device wifi connect'\
    nm-disconnect='nmcli device disconnect'\
    nm-show='nmcli connection show'\
    nm-status='nmcli device'\
    nm-wifi-off='nmcli radio wifi off'\
    nm-wifi-on='nmcli radio wifi on'

# Youtube-dl
alias \
    ydl-audio='youtube-dl -x --audio-format mp3 --audio-quality 0'

# Scripts
alias \
    fm='~/.config/vifm/scripts/vifmrun'\
    d='cd "$(awk "{print $1}" ~/.config/bmdirs | fzf | sed "s|~|$HOME|")"'


# extract files
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Zsh Plugins
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null

# Wal Theme
#(cat ~/.cache/wal/sequences &)
#source ~/.cache/wal/colors-tty.sh

neofetch
