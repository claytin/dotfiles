#!/bin/sh

# close running bar instances
killall -q polybar

# wait until the bar process shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

polybar void &
