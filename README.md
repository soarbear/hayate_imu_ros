# 0. はじめに

hayate_imuは、TDK Invensense ICM-20948を内蔵し、6軸/9軸センサフュージョン、3軸加速度データ、3軸角速度データ、3軸方位(地磁気)データをUSBから出力する9軸IMUセンサである。

hayate_imu_rosは、9軸IMUセンサhayate_imu向けのROSパッケージであり、その扱い方は以下に示す。

# 1. 使用環境

- Ubuntu 16.04 18.04 20.04 推奨

- ROS kinetic melodic noetic 推奨

# 2. 使用手順

## 2.1 プラグインのインストール

※注意 以下のdistroをご使用のROS Distributionに入れ替える。

$sudo apt-get update

$rosversion -d

$sudo apt-get install ros-distro-rosserial

$sudo apt-get install ros-distro-imu-tools
  
例：　ROS Distributionは melodicであれば、

$sudo apt-get install ros-melodic-rosserial

$sudo apt-get install ros-melodic-imu-tools

## 2.2 hayate_imu_rosのインストール

$cd ~/catkin_ws/src

$git clone https://github.com/soarbear/hayate_imu_ros.git

$cd ~/catkin_ws

$catkin_make

## 2.3 パラメータ

- port: /dev/ttyACM_hayate

 - USBポート /dev/ttyACM* (デフォルト：/dev/ttyACM_hayate)

- baud: 115200 

 - USBシリアルボーレート (デフォルト：115200 bps)

- output_rate_q: 200

6 軸または 9 軸融合四元数の出力レート(デフォルト：200Hz、レンジ：Min 50Hz  ～  Max 225Hz) 

- output_rate_a: 1

加速度センサ、ジャイロセンサの出力レート(デフォルト：1Hz、レンジ：Min 1Hz ～ Max 225Hz)

- output_rate_m: 1 

地磁気出力レート(デフォルト：1Hz、レンジ：Min 1Hz ～ Max 75Hz))

- bias_accel_x: 0

加速度センサバイアスX(デフォルト：0、納品書に記載)

- bias_accel_y: 0

加速度センサバイアスY(デフォルト：0、納品書に記載)

- bias_accel_z: 0

加速度センサバイアスZ(デフォルト：0、納品書に記載)

- bias_gyro_x: 0

ジャイロセンサバイアスX(デフォルト：0、納品書に記載)

- bias_gyro_y: 0

ジャイロセンサバイアスY(デフォルト：0、納品書に記載)

- bias_gyro_z: 0

ジャイロセンサバイアスZ(デフォルト：0、納品書に記載)

- bias_magnet_x: 0

地磁気センサバイアスX(デフォルト：0、納品書に記載)

- bias_magnet_y: 0

地磁気センサバイアスY(デフォルト：0、納品書に記載)

- bias_magnet_z: 0

地磁気センサバイアスZ(デフォルト：0、納品書に記載)

## 2.4 パラメータの確認

- params.yamlファイルにあるパラメータport、baud、output_rate_a、output_rate_mを確認して、必要に応じて変更する。

$nano ~/catkin_ws/src/hayate_imu_ros/config/params.yaml

または、$vim ~/catkin_ws/src/hayate_imu_ros/config/params.yaml

- パラメータの変更があったら、hayate imuのUSBを抜き挿しして、もしくはRESETをかけて、再起動させる。

- 併せて、4.トラブルシューティングを参照する。

## 2.5 トピック

- hayate_imu/data(sensor_msgs/Imu)

　　-　6軸フュージョン or 9軸フュージョン回転ベクトル四元数(geometry_msgs/Quaternion)

　　-　加速度(アクセル)3軸データ(geometry_msgs/Vector3)

　　-　角速度(ジャイロ)3軸データ(geometry_msgs/Vector3)

- hayate_imu/magn(sensor_msgs/MagneticField)

　　-　地磁気(コンパス)3軸データ(geometry_msgs/Vector3)

## 2.6 トピックの確認

- USBポート番号をttyACM_hayateに固定する。

$chmod +x ~/catkin_ws/src/hayate_imu_ros/scripts/create_rules.sh

$~/catkin_ws/src/hayate_imu_ros/scripts/create_rules.sh

- hayate_imu_rosを起動する。

$roslaunch hayate_imu_ros hayate_imu.launch

- トピックのデータを確認する。

$rostopic echo hayate_imu/data

$rostopic echo hayate_imu/magn

- トピックの出力レートを確認する。

$rostopic hz -w 100 hayate_imu/data

$rostopic hz -w 100 hayate_imu/magn

- また、USBポート番号のttyACM_hayateを解除する場合、

$chmod +x ~/catkin_ws/src/hayate_imu_ros/scripts/delete_rules.sh

$~/catkin_ws/src/hayate_imu_ros/scripts/delete_rules.sh

## 2.7 6軸／9軸フュージョン四元数の可視化

$roslaunch hayate_imu_ros hayate_imu_demo.launch

# 3. LED表示

- Red = 電源供給USB+5V

- Blue = パケット送受信

- Yellow = 6軸／9軸フュージョン四元数出力 

# 4. トラブルシューティング

## 4.1 wrong checksum

下記インフォメーションは、IMUのUSB対向側装置が受信したパケットのCRCエラーに起因する。hayate imuの出力レートに関わるパラメータoutput_rate_a、output_rate_mを少しずつ下げてみるか、hayate imuのUSB対向側装置リソース(CPUクロック周波数、メモリ容量・スピード)をアップグレードしてみると、下記インフォメーションは消える。

[INFO] [WallTime: 9876543210.0123456789] wrong checksum for topic id and msg

- パラメータ@params.yaml: output_rate_q、output_rate_a、output_rate_mの設定例

Ex0: output_rate_q: 225    output_rate_a: 1      output_rate_m: 1 (デフォルト) 

Ex1: output_rate_q: 100    output_rate_a: 1      output_rate_m: 1   

Ex2: output_rate_q: 200    output_rate_a: 200 　 output_rate_m: 70 

Ex3: output_rate_q: 100    output_rate_a: 100    output_rate_m: 70 

Ex4: output_rate_q: 70     output_rate_a: 70     output_rate_m: 70 

Ex5: output_rate_q: 50     output_rate_a: 50     output_rate_m: 50

- パラメータの変更があったら、hayate imuのUSBを抜き挿しして、もしくはRESETをかけて、再起動させてください。

## 4.2 9軸シュージョン

方位(Yaw)補正済み。地磁気センサが、環境(周囲の磁場、電磁デバイス)の影響を受けやすい場合がある。

# 5. リリース

## 5. 1 ハードウェア
- v2.0 May 2021(最新版)  
- v1.1 March 2021  
## 5. 2 マニュアル  
- v2.2 Jul 2021(最新版)  
- v2.1 Jun 2021
- v2.0 May 2021  

# 6. ライセンス

- 本ROS Package(hayate_imu_ros)に対して、BSD-3-Clauseが適用される。

# 7. 参考情報

## 7.1 主な規格

・ 型番　hayate_imu v2.0 rev.C 6軸フュージョン or 9軸フュージョン両方可能

・ 内蔵チップ　Cortex-M0+、TDK Invensense ICM-20948(9軸)実装

・ 外部接続　USB Type-Cコネクタ、USB+5V給電

・ 最大出力レート  
　　-　6軸フュージョン／9軸フュージョン四元数　225H  
　　-　加速度(アクセル)3軸センサ　　225Hz  
　　-　角速度(ジャイロ)3軸センサ　　225Hz  
　　-　地磁気(コンパス)3軸センサ　　75Hz  

・ 測定レンジ  
　　-　加速度(アクセル)センサ　　±16g  
　　-　角速度(ジャイロ)センサ　　±2000dps  
　　-　地磁気(コンパス)センサ　　±4900µT  

・ 補正機能　補正済み

・ 標準偏差(RMS-Noise)  
　　-　加速度(アクセル)センサ　　±0.026313m/s^2(ノイズ帯域幅136Hz)  
　　-　角速度(ジャイロ)センサ　　±0.0032520rad/s (ノイズ帯域幅154.3Hz)  
　　-　地磁気(コンパス)センサ　　±0.8µT  

・ 消費電力　50mW以下(環境温度21℃ 実測値)

・ 寸法　30mm × 31.4mm × 4.8mm(突起物含む)

・ 重量　4g以下

・ 取付穴　M3x4、隣り合う穴の中心間距離24.4mm

## 7.2 製品紹介

<a href="https://memo.soarcloud.com/icm-20948-cortex-m0%e5%86%85%e8%94%b5-9%e8%bb%b8imu-ros%e5%af%be%e5%bf%9c/">9軸IMUセンサ 6軸／9軸フュージョン 低遅延 USB出力 補正済み ROS対応 | ROBOT翔・技術情報</a>

<a href="https://youtu.be/44SPo_zulMc">9軸IMUセンサ ICM-20948内蔵 6軸／9軸シュージョン 出力レート225Hz 低遅延 USB出力 補正済み ROS対応 | YouTube</a>

## 7.3 取扱店舗

<a href="https://store.soarcloud.com/products/detail/136">9軸IMUセンサ 6軸／9軸フュージョン 低遅延 USB出力 補正済み ROS対応 | ROBOT翔</a>
