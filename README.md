# 0. はじめに

hayate_imu_rosは、TDK Invensense ICM-20948を内蔵した9軸IMUセンサ hayate imuのROS Package、その扱い方は以下に示す。

V2.4 NEWフィーチャとして、較正モードの追加により、ジャイロスコープ、加速度センサ、地磁気センサの初期バイアスは出荷時の測定のみならず、お客様のもとでも測定することはできるようになる。

# 1. 対向環境

- Ubuntu 16.04 18.04 20.04 推奨

- ROS kinetic melodic noetic 推奨

# 2. 使用手順

## 2.1 Install rosserial、rviz_imu_plugin

※注意 以下のdistroをご使用のROS Distributionに入れ替える。

$sudo apt-get update

$rosversion -d

$sudo apt-get install ros-distro-rosserial

$sudo apt-get install ros-distro-imu-tools
  
例：　ROS Distributionは melodicであれば、

$sudo apt-get install ros-melodic-rosserial

$sudo apt-get install ros-melodic-imu-tools

## 2.2 Install hayate_imu_ros

$cd ~/catkin_ws/src

$git clone https://github.com/soarbear/hayate_imu_ros.git

$cd ~/catkin_ws

$catkin_make

## 2.5 Topics

- imu_data(Message: hayate_imu_ros/ImuData), 通常出力モード用 

- imu_cali(Message: hayate_imu_ros/ImuCali), 校正モード用

- imu_demo(Message: sensor_msgs/Imu), デモモード用

## 2.6 Confirm Topics

- USBポート番号をttyACM_hayateに固定する。

$chmod +x ~/catkin_ws/src/hayate_imu_ros/scripts/create_rules.sh

$~/catkin_ws/src/hayate_imu_ros/scripts/create_rules.sh

- hayate_imu_rosを起動する

$roslaunch hayate_imu_ros hayate_imu.launch

- Topicのデータを確認する例

$rostopic echo imu_data

- Topicの出力レートを確認する例

$rostopic hz -w 100 imu_data

- また、USBポート番号のttyACM_hayateを解除する場合、

$chmod +x ~/catkin_ws/src/hayate_imu_ros/scripts/delete_rules.sh

$~/catkin_ws/src/hayate_imu_ros/scripts/delete_rules.sh

## 2.7 6軸／9軸フュージョン四元数の可視化

$roslaunch hayate_imu_ros hayate_imu_demo.launch

# 3. LED

- Red = 電源供給USB+5V

- Blue = パケット送受信

- Yellow = 6軸／9軸フュージョン四元数出力 

# 4. リリース

- v2.4 March 2023. 較正モード、デモモード追加

- v2.0 May 2021.

- v1.1 March 2021.

# 5. ライセンス

- 本ROS Package(hayate_imu_ros)に対して、BSD-3-Clauseが適用される。

# 6. 参考情報

## 6.1 製品紹介

<a href="https://memo.soarcloud.com/icm-20948-cortex-m0%e5%86%85%e8%94%b5-9%e8%bb%b8imu-ros%e5%af%be%e5%bf%9c/">9軸IMUセンサ 6軸／9軸フュージョン ICM-20948 Cortex-M0+内蔵 低遅延 USB出力 ROS対応 | ROBOT翔・技術情報</a>

<a href="https://youtu.be/N3I52f4gxq4">9軸IMUセンサ ICM-20948内蔵 6軸／9軸シュージョン 出力レート225Hz 低遅延 USB出力 ROS対応 | YouTube</a>

## 6.2 取扱店舗

<a href="https://store.soarcloud.com/products/detail/136">9軸IMUセンサ 6軸／9軸フュージョン 低遅延 USB出力 ROS対応 | ROBOT翔</a>
