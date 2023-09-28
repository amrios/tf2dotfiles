#!/bin/bash
#
# Copyright (c) 2023 amrios
#
# This work is free. You can redistribute it and/or modify it under the
# terms of the Do What The Fuck You Want To Public License, Version 2,
# as published by Sam Hocevar. See the COPYING file for more details.

INSTALL_DIR=./tf
PLATFORM=linux

TF_LAUNCH_OPS="-novid -nojow -nosteamcontroller -nohltv -particles 1 -precachefontchars -nostartupsound -console"
TF_LAUNCH_OPS_WIN="-noquicktime"
TF_LAUNCH_OPS_LIN="-gl_amd_pinned_memory"
TF_SENSITIVITY="1.8"
TF_SENSITIVTY_RATIO="0.5"

# Detect if using WSL.
if [[ $(lscpu | grep -E "Windows|Microsoft") ]]
	printf "Detected WSL"
	PLATFORM=windows
fi


if [ $(du $INSTALL_DIR | wc -l) != 1 ]
	printf "ERROR: Install environment ($INSTALL_DIR) not clean"
	exit 2
fi

mkdir $INSTALL_DIR/custom
mkdir $INSTALL_DIR/cfg
mkdir -p $INSTALL_DIR/resource/crosshair

# Step 1: Set up `custom` directory

cd $INSTALL_DIR/custom

# 1a. Mastercomfig

MC_MEDIUM_URL="https://api.mastercomfig.com/download/latest/download/mastercomfig-medium-preset.vpk"
MC_NULLCANCEL_URL="https://api.mastercomfig.com/download/latest/download/mastercomfig-null-canceling-movement-addon.vpk"
MC_FLATMOUSE_URL="https://api.mastercomfig.com/download/latest/download/mastercomfig-flat-mouse-addon.vpk"
MC_OPENGL_URL="https://api.mastercomfig.com/download/latest/download/mastercomfig-opengl-addon.vpk"
MC_VIEWMODEL_URL="https://api.mastercomfig.com/download/latest/download/mastercomfig-transparent-viewmodels-addon.vpk"

MC=($MC_MEDIUM_URL $MC_NULLCANCEL_URL $MC_FLATMOUSE_URL $MC_VIEWMODEL_URL)

if [ $PLATFORM == "linux" ]
	MC+=($MC_OPENGL_URL)
fi

for url in "${MC[@]}"
do
	curl -O $url
done

# 1b. Yayahud
cp ../../3rdparty/yayahud ./


