# 0. はじめに

hayate_imu_rosは、TDK Invensense ICM-20948を内蔵した9軸IMUセンサ hayate imuのROS Package、その扱い方は以下に示す。

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

## 2.3 Parameters

- port: /dev/ttyACM_hayate

USBポート /dev/ttyACM* (デフォルト：/dev/ttyACM_hayate)

- baud: 115200

USBシリアルボーレート (デフォルト：115200 bps)

- output_rate_a: 200

加速度センサ、ジャイロセンサ、6軸または9軸融合四元数の出力レート(デフォルト：200Hz、レンジ：Min 1Hz ～ Max 200Hz)

- output_rate_m: 70

地磁気出力レート(デフォルト：70Hz、レンジ：Min 1Hz ～ Max 70Hz))

## 2.4 Confirm Parameters

- params.yamlファイルにあるパラメータport、baud、output_rate_a、output_rate_mを確認して、必要に応じて変更する。

$nano ~/catkin_ws/src/hayate_imu_ros/config/params.yaml

または、$vim ~/catkin_ws/src/hayate_imu_ros/config/params.yaml

- パラメータの変更があったら、hayate imuのUSBを抜き挿しして、もしくはRESETをかけて、再起動させる。

- 併せて、4.トラブルシューティングを参照する。

## 2.5 Topics

- Topic: hayate_imu/data, Message: sensor_msgs/Imu 

　　-　ver.A 6軸フュージョン or ver.B 9軸フュージョン四元数, Message: geometry_msgs/Quaternion

　　-　加速度(アクセル)3軸データ, Message: geometry_msgs/Vector3

　　-　角速度(ジャイロ)3軸データ, Message: geometry_msgs/Vector3

- Topic: hayate_imu/magn

　　-　地磁気(コンパス)3軸データ, Message: geometry_msgs/Vector3

## 2.6 Confirm Topics

- USBポート番号をttyACM_hayateに固定する。

$chmod +x ~/catkin_ws/src/hayate_imu_ros/scripts/create_rules.sh

$~/catkin_ws/src/hayate_imu_ros/scripts/create_rules.sh

- hayate_imu_rosを起動する。

$roslaunch hayate_imu_ros hayate_imu.launch

- Topicのデータを確認する。

$rostopic echo hayate_imu/data

$rostopic echo hayate_imu/magn

- Topicの出力レートを確認する。

$rostopic hz -w 100 hayate_imu/data

$rostopic hz -w 100 hayate_imu/magn

- また、USBポート番号のttyACM_hayateを解除する場合、

$chmod +x ~/catkin_ws/src/hayate_imu_ros/scripts/delete_rules.sh

$~/catkin_ws/src/hayate_imu_ros/scripts/delete_rules.sh

## 2.7 6軸／9軸フュージョン四元数の可視化

$roslaunch hayate_imu_ros hayate_imu_demo.launch

# 3. LED

- Red = 電源供給USB+5V

- Blue = パケット送受信

- Yellow = 6軸／9軸フュージョン四元数出力 

# 4. トラブルシューティング

## 4.1 wrong checksum

下記インフォメーションは、IMUのUSB対向側装置が受信したパケットのCRCエラーに起因する。hayate imuの出力レートに関わるパラメータoutput_rate_a、output_rate_mを少しずつ下げてみるか、hayate imuのUSB対向側装置リソース(CPUクロック周波数、メモリ容量・スピード)をアップグレードしてみると、下記インフォメーションは消える。

[INFO] [WallTime: 9876543210.0123456789] wrong checksum for topic id and msg

- パラメータ@params.yaml: 出力レートoutput_rate_a、output_rate_mの設定例

ex1:  output_rate_a: 200   output_rate_m: 70

ex2:  output_rate_a: 100   output_rate_m: 70

ex3:  output_rate_a: 70    output_rate_m: 70

ex4:  output_rate_a: 50    output_rate_m: 50

- パラメータの変更があったら、hayate imuのUSBを抜き挿しして、もしくはRESETをかけて、再起動させる。

## 4.2 9軸シュージョン

地磁気センサが、環境(周囲の磁場、電磁デバイス)の影響を受けやすい場合がある。

# 5. リリース

- v1.1 March 2021.

# 6. ライセンス

- 本ROS Package(hayate_imu_ros)に対して、BSD-3-Clauseが適用される。

# 7. 参考情報

## 7.1 製品紹介

<a href="https://memo.soarcloud.com/icm-20948-cortex-m0%e5%86%85%e8%94%b5-9%e8%bb%b8imu-ros%e5%af%be%e5%bf%9c/">9軸IMU 6軸／9軸フュージョン ICM-20948 Cortex-M0+内蔵 低遅延 ROS対応 | ROBOT翔・技術情報</a>

<a href="https://youtu.be/N3I52f4gxq4">9軸IMU 6軸／9軸シュージョン 出力レート225Hz USB接続 ROS対応 | YouTube</a>

## 7.2 取扱店舗

<a href="https://store.soarcloud.com/products/detail/136">9軸IMU 6軸／9軸フュージョン 低遅延 USB出力 ROS対応 | ROBOT翔</a>
