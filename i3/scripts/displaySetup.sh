#!/bin/bash

# internal display
P50="eDP-1-1"
# DELL 28" Display
DELL="DP-3.1"
# Samsung 23" Display
SAM="DP-3.2"
# Home TV
TV=HDMI1

# internal display is always connected
xrandr --output ${P50} --mode 1920x1080

# check if Lenovo 24" Display is connected
function isDellConnected() {
	if(xrandr | grep "${DELL} connected" > /dev/null 2>&1); then
		return 0
	else
		return 1
	fi
}

# check if Lenovo 28" Display is connected
function isSamConnected() {
	if(xrandr | grep "${SAM} connected" > /dev/null 2>&1); then
		return 0
	else
		return 1
	fi
}

# check if TV Display is connected
function isTVConnected() {
	if(xrandr | grep "${TV} connected" > /dev/null 2>&1); then
		return 0
	else
		return 1
	fi
}

# add 1920x1080 mode for internal display
#if(! (xrandr | grep "1920x1080_60_DP1" > /dev/null 2>&1)); then
#	xrandr --newmode 1920x1080_60_DP1  172.80  1920 2040 2248 2576  1080 1081 1084 1118  -HSync +Vsync
#	xrandr --addmode ${W541} "1920x1080_60_DP1"
#fi

# if both monitors are connected
if(isDellConnected && isSamConnected); then
	# turn off internal display
	xrandr --output ${P50} --off
	# arrange Lenovo 28" Display left from internal display
	xrandr --output ${DELL} --primary
	# arrange Lenovo 24" Display left from Lenovo 28" Display
	xrandr --output ${SAM} --left-of ${DELL}
else
	xrandr --output ${P50} --auto --mode 1920x1080

	if(isTVConnected); then
		xrandr --output ${TV} --auto --left-of ${P50}
	fi
fi

# itellij ibus stuff
export IBUS_ENABLE_SYNC_MODE=1
