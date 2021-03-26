# はじめに

hayate_imu_rosは、TDK Invencese ICM-20948を内蔵した9軸IMUセンサ hayate_imuのROS Package、その扱い方を以下に示す。

# 対向環境

- Ubuntu 16.04 18.04 20.04 推奨

- ROS kinetic melodic noetic 推奨

# 使用手順

## rosserial、rviz_imu_plugin install

※注意 以下のdistroをご使用のROS Distributionに入れ替える。

$sudo apt-get update

$rosversion -d

$sudo apt-get install ros-distro-rosserial

$sudo apt-get install ros-distro-imu-tools
  
例：　ROS Distributionは melodicであれば、

$sudo apt-get install ros-melodic-rosserial

$sudo apt-get install ros-melodic-imu-tools

## hayate_imu_ros install

$cd ~/catkin_ws/src

$git clone https://github.com/soarbear/hayate_imu_ros.git

$cd ~/catkin_ws

$catkin_make

## ROS Topic

- Topic: hayate_imu/data, Message: sensor_msgs/Imu 

　　-　ver.A 6軸フュージョン or ver.B 9軸フュージョン四元数, Message: geometry_msgs/Quaternion

　　-　加速度(アクセル)3軸データ, Message: geometry_msgs/Vector3

　　-　角速度(ジャイロ)3軸データ, Message: geometry_msgs/Vector3

- Topic: hayate_imu/magn

　　-　地磁気(コンパス)3軸データ, Message: geometry_msgs/Vector3

- USBポート番号をttyACM_hayateに固定する。

$chmod +x ~/catkin_ws/src/hayate_imu_ros/scripts/create_rules.sh

$~/catkin_ws/src/hayate_imu_ros/scripts/create_rules.sh

- params.yamlファイルにあるパラメータport、baud、output_rate_a、output_rate_mを確認して、必要に応じて変更する。

併せて、以下のトラブルシューティングを参照する。

$nano ./src/hayate_imu_ros/config/params.yaml

または、$vim ./src/hayate_imu_ros/config/params.yaml

- hayate_imu_rosを起動する。

$roslaunch hayate_imu_ros hayate_imu.launch

- Topicのデータを確認する。

$rostopic echo hayate_imu/data

$rostopic echo hayate_imu/magn

- Topicの出力レートを確認する。

$rostopic hz -w 10 hayate_imu/data

$rostopic hz -w 10 hayate_imu/magn

- また、USBポート番号のttyACM_hayateを解除する場合、

$chmod +x ~/catkin_ws/src/hayate_imu_ros/scripts/delete_rules.sh

$~/catkin_ws/src/hayate_imu_ros/scripts/delete_rules.sh

# 6軸／9軸フュージョン四元数の可視化

$roslaunch hayate_imu_ros hayate_imu_demo.launch

# トラブルシューティング

## wrong checksum

下記インフォメーションは、IMUのUSB対向側装置が受信したパケットのCRCエラーに起因する。hayate_imuの出力レートに関わるパラメータoutput_rate_a、output_rate_mを少しずつ下げてみるか、hayate_imuのUSB対向側装置リソース(CPUクロック周波数、メモリ)をアップグレードしてみると、下記インフォメーションは消える。

[INFO] [WallTime: 9876543210.0123456789] wrong checksum for topic id and msg

- パラメータ@params.yaml: 出力レートoutput_rate_a、output_rate_mの設定例

ex1:  output_rate_a: 200   output_rate_m: 70

ex2:  output_rate_a: 100   output_rate_m: 70

ex3:  output_rate_a: 70    output_rate_m: 70

ex4:  output_rate_a: 50    output_rate_m: 50

- hayate_imuのUSBを抜き挿しして、再起動させる。

## 9軸フュージョン

地磁気センサ使用のため、場所によって、9軸フュージョンは環境(周囲の磁場)の影響を受けやすい場合がある。

# 参考情報

- 製品紹介

<a href="https://memo.soarcloud.com/icm-20948-cortex-m0%e5%86%85%e8%94%b5-9%e8%bb%b8imu-ros%e5%af%be%e5%bf%9c/">ICM-20948 Cortex-M0+内蔵 9軸IMU 6軸／9軸フュージョン ROS対応 | ROBOT翔・技術情報</a>

- 販売店舗

<a href="https://store.soarcloud.com/products/detail/136">9軸IMU 6軸／9軸フュージョン ROS対応 | ROBOT翔・販売</a>

# リリース

v1.1 March 2021.
