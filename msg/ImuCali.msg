std_msgs/Header header

# Unit: dps, angular velocity
geometry_msgs/Vector3 angular_velocity

# Unit: dps, bias of angular velocity
geometry_msgs/Vector3 angular_bias

# Gyroscope calibation indicator, 0(oringinal) -> 3(best)
uint32 angular_calibration_indicator

# Unit: m/s^2, linear acceleration
geometry_msgs/Vector3 linear_acceleration

# Unit: m/s^2, bias of linear acceleration
geometry_msgs/Vector3 accel_bias

# Accelerometer calibation indicator, 0(oringinal) -> 3(best)
uint32 accel_calibration_indicator

# Unit: uT, magnetic field
geometry_msgs/Vector3 magnetic_field

# Unit: uT, bias of linear acceleration
geometry_msgs/Vector3 magnetic_bias

# Magetometer calibation indicator, 0(oringinal) -> 3(best)
uint32 magnetic_calibration_indicator
