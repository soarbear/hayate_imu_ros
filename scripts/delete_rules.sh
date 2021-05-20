#!/bin/bash

echo "delete remap the device serial port(ttyACM*) of hayate_imu"
echo "sudo rm /etc/udev/rules.d/hayate_imu.rules"
sudo rm /etc/udev/rules.d/hayate_imu.rules
echo ""
echo "restarting udev..."
echo ""
sudo service udev reload
sudo service udev restart
echo "done"
