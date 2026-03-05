#!/bin/bash

# Reload I2C HID modules to fix FTSC1000 touchscreen initialization
# Huawei Matebook 14 has issues where the touchscreen fails to start on boot

# Remove problematic modules
sudo modprobe -r hid_multitouch 2>/dev/null
sudo modprobe -r i2c_hid_acpi 2>/dev/null
sudo modprobe -r i2c_hid 2>/dev/null

# Reload modules
sudo modprobe i2c_hid_acpi
sudo modprobe i2c_hid
sudo modprobe hid_multitouch