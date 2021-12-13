# vcore-slider
A simple camera slider for the Rat Rig V-Core 3d printer

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
