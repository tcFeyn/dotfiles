#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi


# Keyboard and Mouse Settings
numlockx & # turns numlock on
setxkbmap us & # keyboard language
setxkbmap -option caps:swapescape & # swaps capslock with esc key
xset r on &
xset r rate 300 50 &
xset b off &
xsetroot -cursor_name left_ptr & # set mouse cursor
xinput --set-prop "SteelSeries SteelSeries Rival 3" "libinput Accel Speed" -1

# Screen Settings
xrandr --output DisplayPort-1 --mode 1920x1080 --rate 144.00 --pos 0x0 --rotate normal
xrandr --output DisplayPort-0 --primary --mode 1920x1080 --rate 144.00 --pos 1920x0 --rotate normal

xrdb -merge ~/.Xresources &

# Startup Apps
picom --config $HOME/.config/picom.conf &
feh --bg-fill ~/Docs/Github/Color-schemes-And-Wallpapers/Wallpapers/Nord/nord4.png --bg-fill ~/Docs/Github/Color-schemes-And-Wallpapers/Wallpapers/Nord/nord1.png &
redshift -P -O 4600 &
#mpd &
flameshot &
clipmenud &
xfce4-power-manager &
#volctl &
#nm-applet &
/usr/lib/mate-polkit/polkit-mate-authentication-agent-1 &
#dunst &
syncthing -no-browser &

# Create Virtual Cable for OBS
pactl load-module module-null-sink sink_name=Source
pactl load-module module-virtual-source source_name=VirtualMic master=Source.monitor

# Update Dir list
find /home/david/{Downloads,Pictures,Docs/{Github,Phone,Scripts,Server,Faculdade}} -type d | grep -v .git | grep -v CTeSP > /home/david/.config/dirs.txt

~/Docs/Scripts/Various/restart_spotify &

# Exec WM
exec awesome
