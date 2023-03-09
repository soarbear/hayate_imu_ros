std_msgs/Header header

# Unit: rad/s, angular velocity
geometry_msgs/Vector3 angular_velocity

# Unit: (rad/s)^2, angular velocity covariance
float64[9] angular_velocity_covariance

# Unit: m/s^2, linear acceleration
geometry_msgs/Vector3 linear_acceleration

# Unit: (m/s^2)^2, linear acceleration covariance
float64[9] linear_acceleration_covariance

# Unit: uT, magnetic field
geometry_msgs/Vector3 magnetic_field

# Unit: (uT)^2, magnetic field covariance
float64[9] magnetic_field_covariance

# 6axis/9axis fusion rotation vector quaternion
geometry_msgs/Quaternion orientation

# 6axis/9axis fusion rotation vector quaternion covariance
float64[9] orientation_covariance
