# vcore-slider
A simple camera slider for the Rat Rig V-Core 3d printer

V-Core Slider is Uberlapse compatible and lets you create timelapses of your 3d prints.   
Moonraker: https://github.com/HelgeKeck/uberlapse/   

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

[include vcore-slider/config.cfg]

```
