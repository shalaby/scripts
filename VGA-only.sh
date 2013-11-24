#!/bin/sh

res_knw=1360x768    # resolution known to work
res_dsr=1280x720_60 # resolution desired
res_dsn=1280x720    # resolution desiredname

# Turn on monitor
xrandr --output VGA-0 --mode $res_dsn

# Desired resolution if possible
xrandr --output VGA-0 --mode $res_dsn --pos 0x0 --rotate normal --output eDP --off --output HDMI-0 --off 2&> /dev/null

if [[ $? != 0 ]]; then
  xrandr --addmode VGA-0 $res_dsn
  xrandr --newmode       $res_dsr  74.50  1280 1344 1472 1664  720 723 728 748 \
    -hsync +vsync
  xrandr --output VGA-0 --mode $res_dsn --pos 0x0 --rotate normal --output eDP --off --output HDMI-0 --off; fi