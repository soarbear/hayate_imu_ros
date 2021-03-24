# はじめに

hayate_imu_rosは、TDK Invencese ICM-20948を内蔵した9軸IMUセンサ hayate_imuのROS Package、その扱い方を以下に示す。

# 動作環境

- Ubuntu 16.04以降　推奨

- ROS kinetic以降　推奨

# 使用手順

## rosserial、rviz_imu_pluginのインストール

※注意 以下のdistroをご使用のROS Distributionに入れ替える。

$sudo apt-get update

$rosversion -d

$sudo apt-get install ros-distro-rosserial

$sudo apt-get install ros-distro-imu-tools
  
例：　ROS Distributionは melodicであれば、

$sudo apt-get install ros-melodic-rosserial

$sudo apt-get install ros-melodic-imu-tools

## hayate_imu_rosのインストール

$cd ~/catkin_ws/src

$git clone https://github.com/soarbear/hayate_imu_ros.git

$cd ~/catkin_ws

$catkin_make

## フュージョン四元数の可視化

- USBポート番号をttyACM_hayateに固定する。

$chmod +x ~/catkin_ws/src/hayate_imu_ros/scripts/create_rules.sh

$~/catkin_ws/src/hayate_imu_ros/scripts/create_rules.sh

- params.yamlファイルのport番号を確認する。

$nano ./src/hayate_imu_ros/config/params.yaml

または、$vim ./src/hayate_imu_ros/config/params.yaml

- hayate_imu_rosを起動する。

$roslaunch hayate_imu_ros hayate_imu_demo.launch

- また、USBポート番号のttyACM_hayateを解除する場合、

$chmod +x ~/catkin_ws/src/hayate_imu_ros/scripts/delete_rules.sh

$~/catkin_ws/src/hayate_imu_ros/scripts/delete_rules.sh

# ROS Topicについて

- Topic: hayate_imu/data, Message: sensor_msgs/Imu 

　　-　ver.A 6軸フュージョン or ver.B 9軸フュージョン四元数, Message: geometry_msgs/Quaternion

　　-　加速度(アクセル)3軸データ, Message: geometry_msgs/Vector3

　　-　角速度(ジャイロ)3軸データ, Message: geometry_msgs/Vector3

- Topic: hayate_imu/magn

　　-　地磁気(コンパス)3軸データ, Message: geometry_msgs/Vector3

- Topicのデータを確認する。

$rostopic echo hayate_imu/data

$rostopic echo hayate_imu/magn

- Topicの出力レートを確認する。

$rostopic hz -w 10 hayate_imu/data

$rostopic hz -w 10 hayate_imu/magn

# リリース

v1.1 March 2021.
