#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
#
## Rofi   : Launcher (Modi Drun)
#
## Style  : launchers type-6 / style-10

dir="$HOME/.config/rofi/launcher"

## Run
rofi \
    -show drun \
    -theme "${dir}/style.rasi"
