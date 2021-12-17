#!/bin/bash
# Uberlapse Macro installer
#
# taken from https://github.com/mainsail-crew/moonraker-timelapse and modified
# below comments are original
#
# Copyright (C) 2021 Christoph Frei <fryakatkop@gmail.com>
# Slightly modified by Stephan Wendel aka KwadFan <me@stephanwe.de>
#
# This file may be distributed under the terms of the GNU GPLv3 license.
#
# Note:
# this installer script is heavily inspired by 
# https://github.com/protoloft/klipper_z_calibration/blob/master/install.sh

# Prevent running as root.
if [ ${UID} == 0 ]; then
    echo -e "DO NOT RUN THIS SCRIPT AS 'root' !"
    echo -e "If 'root' privileges needed, you will prompted for sudo password."
    exit 1
fi

# Force script to exit if an error occurs
set -e

# Find SRCDIR from the pathname of this script
SRCDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )"/ && pwd )"

# Default Parameters
KLIPPER_CONFIG_DIR="${HOME}/klipper_config"
VCS_ROOT_DIR="${HOME}/klipper_config/vcore_slider"
VCS_BOARD_DIR="${HOME}/klipper_config/vcore_slider/board"
VCS_STEPPER_DIR="${HOME}/klipper_config/vcore_slider/stepper"

function stop_klipper {
    if [ "$(sudo systemctl list-units --full -all -t service --no-legend | grep -F "klipper.service")" ]; then
        echo "Klipper service found! Stopping during Install."
        sudo systemctl stop klipper
    else
        echo "Klipper service not found, please install Klipper first"
        exit 1
    fi
}

function start_klipper {
    echo "Restarting Klipper service!"
    sudo systemctl restart klipper
}

function create_folders {
    if [ -d "${KLIPPER_CONFIG_DIR}" ]; then
        echo "Creating vcore slider folder..."
        mkdir "${VCS_ROOT_DIR}"
    else
        echo -e "ERROR: ${KLIPPER_CONFIG_DIR} not found."
        echo -e "Try:\nUsage: ${0} -c /path/to/klipper_config\nExiting..."
        exit 1
    fi
    if [ -d "${VCS_ROOT_DIR}" ]; then
        echo "Creating vcore slider folder..."
        mkdir "${VCS_BOARD_DIR}"
        mkdir "${VCS_STEPPER_DIR}"
    else
        echo -e "ERROR: ${VCS_BOARD_DIR} not found."
        echo -e "Try:\nUsage: ${0} -c /path/to/klipper_config\nExiting..."
        exit 1
    fi
}

function link_macros {
    if [ -d "${KLIPPER_CONFIG_DIR}" ]; then
        if [ -d "${VCS_ROOT_DIR}" ]; then
            echo "Linking uberlapse macro file..."
            ln -sf "${SRCDIR}/klipper_macro/uberlapse.cfg" "${VCS_ROOT_DIR}/uberlapse.cfg"
            echo "Linking config macro file..."
            ln -sf "${SRCDIR}/klipper_macro/config.cfg" "${VCS_ROOT_DIR}/config.cfg"
            echo "Linking macros macro file..."
            ln -sf "${SRCDIR}/klipper_macro/macros.cfg" "${VCS_ROOT_DIR}/macros.cfg"
            echo "Linking skr_mini_e3v2 macro file..."
            ln -sf "${SRCDIR}/klipper_macro/board/skr_mini_e3v2.cfg" "${VCS_BOARD_DIR}/skr_mini_e3v2.cfg"
            echo "Linking pan macro file..."
            ln -sf "${SRCDIR}/klipper_macro/stepper/pan.cfg" "${VCS_STEPPER_DIR}/pan.cfg"
            echo "Linking slider macro file..."
            ln -sf "${SRCDIR}/klipper_macro/stepper/slider.cfg" "${VCS_STEPPER_DIR}/slider.cfg"
        else
            echo -e "ERROR: ${UBERLAPSE_CONFIG_DIR} not found."
            echo -e "Try:\nUsage: ${0} -c /path/to/klipper_config\nExiting..."
            exit 1
        fi
    else
        echo -e "ERROR: ${KLIPPER_CONFIG_DIR} not found."
        echo -e "Try:\nUsage: ${0} -c /path/to/klipper_config\nExiting..."
        exit 1
    fi
}

### MAIN

# Parse command line arguments
while getopts "c:h" arg; do
    if [ -n "${arg}" ]; then
        case $arg in
            c)
                KLIPPER_CONFIG_DIR=$OPTARG
                break
            ;;
            [?]|h)
                echo -e "\nUsage: ${0} -c /path/to/klipper_config"
                exit 1
            ;;
        esac
    fi
    break
done

# Run steps
stop_klipper
create_folders
link_macros
start_klipper

# If something checks status of install
exit 0
