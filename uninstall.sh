#!/bin/bash

if [[ $(id -u) != 0 ]]; then
	echo "Please, run this script as root (using sudo for example)"
	exit 1
fi

if ! modprobe -r i2c-dev; then
	echo "i2c-dev module cannot be removed successfuly..."
	exit 1
fi

if ! systemctl stop asus_touchpad_numpad; then
	echo "asus_touchpad_numpad.service cannot be stopped correctly..."
	exit 1
fi

if ! systemctl disable asus_touchpad_numpad; then
	echo "asus_touchpad_numpad.service cannot be disabled correctly..."
	exit 1
fi

if ! rm -f /lib/systemd/system/asus_touchpad_numpad.service; then
	echo "/lib/systemd/system/asus_touchpad_numpad.service cannot be removed correctly..."
	exit 1
fi

if ! rm -rf /usr/share/asus_touchpad_numpad-driver/; then
	echo "/usr/share/asus_touchpad_numpad-driver/ cannot be removed correctly..."
	exit 1
fi

if ! rm -rf /var/log/asus_touchpad_numpad-driver; then
	echo "/var/log/asus_touchpad_numpad-driver cannot be removed correctly..."
	exit 1
fi

echo "Asus touchpad python driver uninstalled"
exit 0
