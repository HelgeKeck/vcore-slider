# vcore-slider
A simple camera slider for the Rat Rig V-Core 3d printer

# Uberlapse
V-Core Slider is Uberlapse compatible and lets you create timelapses of your 3d prints.   
Uberlapse: https://github.com/HelgeKeck/uberlapse/   

## Example Uberlapse Video
[![Video Example](https://img.youtube.com/vi/mwse5W7BPuA/0.jpg)](https://www.youtube.com/watch?v=mwse5W7BPuA)    

# Installation

## On your Raspberry
```
cd ~/
git clone https://github.com/HelgeKeck/vcore-slider.git
bash ~/vcore-slider/install.sh
```

## Configure Moonraker update manager
```ini
# moonraker.conf

[update_manager vcore-slider]
type: git_repo
primary_branch: main
path: ~/vcore-slider
origin: https://github.com/HelgeKeck/vcore-slider.git
```

## Define the Gcode Macro
```ini
# printer.cfg

[include vcore_slider/config.cfg]

```
