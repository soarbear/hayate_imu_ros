#!/bin/bash
echo "remap the device serial port(ttyUSB*) to hayate_imu"
echo "hayate_imu usb connection as /dev/hayate_imu, check it using command: ls -l /dev|grep ttyUSB"
echo "start copy hayate_imu.rules to /etc/udev/rules.d/"
echo "`rospack find hayate_imu_ros`/scripts/hayate_imu.rules"
sudo cp `rospack find hayate_imu_ros`/scripts/hayate_imu.rules /etc/udev/rules.d
echo ""
echo "restarting udev..."
echo ""
sudo service udev reload
sudo service udev restart
echo "done"
