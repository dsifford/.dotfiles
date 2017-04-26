# shellcheck shell=sh disable=SC1090

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
    [ -x "$f" ] && . "$f"
    done
    unset f
fi


[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

/usr/bin/numlockx on
# /home/dsifford/bin/screenlayout
/usr/bin/xrandr --output DP-2 --primary --mode 3840x2160 --pos 2160x0 --rotate normal --output DP-4 --mode 3840x2160 --pos 0x0 --rotate right

udiskie &

exec i3 -V >> ~/i3log-"$(date +'%F-%k-%M-%S')" 2>&1
