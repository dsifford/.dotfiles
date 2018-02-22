# shellcheck shell=bash disable=SC1090

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

# Increase key repeat rate
xset r rate 200 60

# Init display output
xrandr \
    --output DP-2 \
        --primary \
        --mode 3840x2160 \
        --pos 2160x0 \
        --rotate normal \
    --output DP-0 \
        --mode 3840x2160 \
        --pos 0x0 \
        --rotate right

numlockx &
udiskie &

exec i3 >> ~/i3log-"$(date +'%F-%k-%M-%S')" 2>&1
